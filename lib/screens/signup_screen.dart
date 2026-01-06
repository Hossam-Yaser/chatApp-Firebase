import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/custom_text_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static String id = 'signupscreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String username;

  late String email;

  late String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          showSnackBar(context, "email created Successfully");

          Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
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
                        SizedBox(height: 40),
                        Image.asset('assets/images/signupText.png'),
                        SizedBox(height: 40),
                        CustomTextfield(
                          hintText: "Username",
                          onChanged: (value) {
                            username = value;
                          },
                          formValidator: usernameValidatorForm,
                        ),
                        SizedBox(height: 20),
                        CustomTextfield(
                          hintText: "Email",
                          onChanged: (value) {
                            email = value;
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
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).registerUser(
                                  email: email,
                                  password: password,
                                );
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          normalText: "Already have an account?",
                          buttonText: "Login",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
