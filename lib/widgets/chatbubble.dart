import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatBubleReciver extends StatelessWidget {
  ChatBubleReciver({super.key, required this.insideText});
  String insideText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          insideText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubleSender extends StatelessWidget {
  ChatBubleSender({super.key, required this.insideText});
  String insideText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          insideText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
