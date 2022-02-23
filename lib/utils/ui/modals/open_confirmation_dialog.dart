import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?>? openConfirmationDialog(BuildContext context,
    {required String content, required VoidCallback accept}) {
  if (Platform.isAndroid) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          showAndroidAlertDialog(context, content, accept),
    );
  } else if (Platform.isIOS) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          showIOSAlertDialog(context, content, accept),
    );
  }

  return null;
}

AlertDialog showAndroidAlertDialog(
    BuildContext context, String content, VoidCallback accept) {
  return AlertDialog(
    title: const Text('Confirmación'),
    content: Text(content),
    actions: <Widget>[
      TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar', style: TextStyle(color: Colors.grey))),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            accept();
          },
          child: const Text('Aceptar')),
    ],
  );
}

CupertinoAlertDialog showIOSAlertDialog(
    BuildContext context, String content, VoidCallback accept) {
  return CupertinoAlertDialog(
    title: const Text('Confirmación'),
    content: Text(content),
    actions: <Widget>[
      CupertinoDialogAction(
        textStyle: const TextStyle(color: Colors.red),
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            accept();
            Navigator.pop(context);
          },
          child: const Text('Aceptar')),
    ],
  );
}
