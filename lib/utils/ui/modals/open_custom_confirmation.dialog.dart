import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogOption {
  String label;
  VoidCallback onPressed;
  bool isPrimary;

  DialogOption(
      {required this.onPressed, required this.label, this.isPrimary = false});
}

DialogOption dialogCancelOption =
    DialogOption(onPressed: () {}, label: 'Cancelar');

Future<DialogOption?> openCustomConfirmDialog(
    BuildContext context, String title, List<DialogOption> options) async {
  if (Platform.isAndroid) {
    return await showDialog<DialogOption>(
      context: context,
      builder: (BuildContext context) => _showAndroidAlertDialog(
          context, title, [...options, dialogCancelOption]),
    );
  } else if (Platform.isIOS) {
    return await showDialog<DialogOption>(
      context: context,
      builder: (BuildContext context) =>
          _showIOSAlertDialog(context, title, [...options, dialogCancelOption]),
    );
  }

  return null;
}

AlertDialog _showAndroidAlertDialog(
    BuildContext context, String title, List<DialogOption> options) {
  return AlertDialog(
    content: SizedBox(
      height: 50 + options.length * 45,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 22),
          Column(children: [
            ...options.map((option) {
              if (option.isPrimary) {
                return SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      option.onPressed();
                      Navigator.pop(context, option);
                    },
                    child: Text(option.label),
                  ),
                );
              }
              return InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      width: double.infinity,
                      child: Text(
                        option.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.blue, fontSize: 14.0),
                      )),
                  onTap: () {
                    option.onPressed();
                    Navigator.pop(context, option);
                  });
            }),
          ])
        ],
      ),
    ),
  );
}

CupertinoAlertDialog _showIOSAlertDialog(
    BuildContext context, String title, List<DialogOption> options) {
  return CupertinoAlertDialog(
    content: SizedBox(
      height: 232,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Column(children: [
            ...options.map((option) {
              if (option.isPrimary) {
                return CupertinoButton(
                    color: Colors.blue,
                    onPressed: () {
                      option.onPressed();
                      Navigator.pop(context);
                    },
                    child: const Text('Publicar'));
              }
              return CupertinoButton(
                  onPressed: () {
                    option.onPressed();
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar como borrador'));
            }),
            CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
          ])
        ],
      ),
    ),
  );
}
