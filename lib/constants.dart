import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff24786D);
const kSecondaryColor = Colors.green;
const emailValidatorForm =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const passwordValidatorForm = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
const usernameValidatorForm = r'^[a-zA-Z0-9_]{3,}$';
const String kFirestoreMessagesCollection = 'messages';
const String kMessage = "message";
const String kSendTime = "sendTime";
