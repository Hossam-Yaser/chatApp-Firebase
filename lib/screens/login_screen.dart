import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:chat_app/widgets/custom_text_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'loginscreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String emailAddress;

  late String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Image.asset('assets/images/chatbox.png'),
                    SizedBox(height: 80),
                    Image.asset('assets/images/loginText.png'),
                    SizedBox(height: 40),
                    CustomTextfield(
                      hintText: "Email",
                      onChanged: (value) {
                        emailAddress = value;
                      },
                      formValidator: emailValidatorForm,
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      hintText: "Password",
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      formValidator: passwordValidatorForm,
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          isLoading = true;
                          setState(() {});

                          if (formKey.currentState!.validate()) {
                            try {
                              UserCredential credential =
                                  await FirebaseServices(
                                    email: emailAddress,
                                    password: password,
                                  ).loginUser();
                              showSnackBar(
                                context,
                                "logged in ${credential.user?.email}",
                              );
                              Navigator.pushNamed(
                                context,
                                ChatScreen.id,
                                arguments: emailAddress,
                              );
                            } on FirebaseAuthException catch (e) {
                              String message;

                              switch (e.code) {
                                case 'user-not-found':
                                  message = 'No user found for that email.';
                                  break;
                                case 'wrong-password':
                                case 'invalid-credential': // new version of wrong password
                                  message =
                                      'Wrong password provided for that user.';
                                  break;
                                case 'invalid-email':
                                  message = 'The email address is not valid.';
                                  break;
                                case 'user-disabled':
                                  message =
                                      'This user account has been disabled.';
                                  break;
                                case 'too-many-requests':
                                  message =
                                      'Too many attempts. Try again later.';
                                  break;
                                default:
                                  message =
                                      'Login failed: ${e.message ?? 'Unknown error'}';
                              }

                              showSnackBar(context, message);
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
