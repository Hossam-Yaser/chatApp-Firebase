import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  String hintText;
  bool obscureText;
  Function(String)? onChanged;
  String formValidator;
  CustomTextfield({
    super.key,
    required this.hintText,
    required this.formValidator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (RegExp(formValidator).hasMatch(value)) {
          return null;
        } else {
          return 'Invalid $hintText';
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "Pacifico",
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff24786D)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff24786D)),
        ),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
