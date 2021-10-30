import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showError(String message) {
    _showToast(message, Colors.red);
  }

   static void showSuccess(String message) {
    _showToast(message, Colors.blueAccent);
  }

  static void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
