import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          emit(LoginFailure(errorMessage: message));
          break;
        case 'wrong-password':
        case 'invalid-credential': // new version of wrong password
          message = 'Wrong password provided for that user.';
          emit(LoginFailure(errorMessage: message));
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          emit(LoginFailure(errorMessage: message));
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          emit(LoginFailure(errorMessage: message));
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try again later.';
          emit(LoginFailure(errorMessage: message));
          break;
        default:
          message = 'Login failed: ${e.message ?? 'Unknown error'}';
          emit(LoginFailure(errorMessage: message));
      }
    }
  }
}
