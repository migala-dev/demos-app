import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?>? confirmation(BuildContext context,
    {required String title,
    required String content,
    required VoidCallback accept}) {
  if (Platform.isAndroid) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: accept,
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  } else if (Platform.isIOS) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: accept,
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
