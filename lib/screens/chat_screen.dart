import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chatbubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          'Chat Box',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 24,
            fontFamily: "Pacifico",
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: BlocProvider.of<ChatCubit>(context).reciveMessage(),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          final Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          return data['sender'] == userEmail
                              ? ChatBubleSender(
                                  insideText: data[kMessage] ?? '',
                                )
                              : ChatBubleReciver(
                                  insideText: data[kMessage] ?? '',
                                );
                        },
                      );
                    },
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: messageController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(message: value, email: userEmail ?? "");
                  messageController.clear();
                  _scrollController.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.ease,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: "Type your message here...",
                suffixIcon: IconButton(
                  onPressed: () {
                    final value = messageController.text.trim();
                    if (value.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(
                        context,
                      ).sendMessage(message: value, email: userEmail ?? "");
                      messageController.clear();
                      _scrollController.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.ease,
                      );
                    }
                  },
                  icon: Icon(Icons.send, color: kPrimaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
