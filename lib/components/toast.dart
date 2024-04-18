import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future buildToast(String message,
    {Color backgroundColor = const Color(0xffe7d9ff), Color textColor = const Color(0xbf000000)}) {
  return Fluttertoast.showToast(
    msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}
