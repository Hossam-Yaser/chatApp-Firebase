import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  final String? normalText;
  final String? buttonText;

  CustomTextButton({
    super.key,
    this.normalText,
    this.buttonText,
    required this.onPressed,
  });

  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText ?? "Don't have an account?",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "Pacifico",
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText ?? "Sign Up",
            style: TextStyle(
              color: Color(0xff24786D),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ],
    );
  }
}
