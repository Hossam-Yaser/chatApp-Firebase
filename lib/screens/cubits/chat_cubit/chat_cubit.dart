import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  void sendMessage({required String message, required String email}) {
    CollectionReference messages = FirebaseFirestore.instance.collection(
      kFirestoreMessagesCollection,
    );
    messages.add({
      kMessage: message,
      kSendTime: FieldValue.serverTimestamp(),
      kSender: email,
    });
  }

  Stream<QuerySnapshot<Object?>> reciveMessage() {
    final Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance
        .collection(kFirestoreMessagesCollection)
        .orderBy(kSendTime, descending: true)
        .snapshots(includeMetadataChanges: true);
    return chatStream;
  }
}
