import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?>? openAlertDialog(BuildContext context,
    {required String content}) {
  if (Platform.isAndroid) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showAndroidAlertDialog(context, content),
    );
  } else if (Platform.isIOS) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => _showIOSAlertDialog(context, content),
    );
  }
}

AlertDialog _showAndroidAlertDialog(BuildContext context, String content) {
  return AlertDialog(
    title: const Text('Alerta'),
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

CupertinoAlertDialog _showIOSAlertDialog(BuildContext context, String content) {
  return CupertinoAlertDialog(
    title: const Text('Alerta'),
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
