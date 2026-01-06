import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/widgets/custom_text_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String id = 'loginscreen';

  late String emailAddress;

  late String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).loginUser(
                                email: emailAddress,
                                password: password,
                              );
                            }
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
      ),
    );
  }
}
