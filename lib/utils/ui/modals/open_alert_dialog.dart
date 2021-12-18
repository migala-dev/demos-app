import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?>? openAlertDialog(BuildContext context,
    {required String content, required String title}) {
  if (Platform.isAndroid) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showAndroidAlertDialog(context, content, title),
    );
  } else if (Platform.isIOS) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showIOSAlertDialog(context, content, title),
    );
  }
}

AlertDialog _showAndroidAlertDialog(
    BuildContext context, String content, String title) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Aceptar')),
    ],
  );
}

CupertinoAlertDialog _showIOSAlertDialog(
    BuildContext context, String content, String title) {
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Aceptar')),
    ],
  );
}
