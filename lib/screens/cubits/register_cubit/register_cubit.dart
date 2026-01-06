import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        emit(RegisterFailure(errorMessage: message));
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        emit(RegisterFailure(errorMessage: message));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'Something went Wrong!!'));
    }
  }
}
