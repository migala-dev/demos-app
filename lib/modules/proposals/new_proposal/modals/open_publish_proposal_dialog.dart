import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> openPublishProposalDialog(BuildContext context,
    {required VoidCallback onPublish,
    required VoidCallback onSaveDraft}) async {
  if (Platform.isAndroid) {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showAndroidAlertDialog(context, onPublish, onSaveDraft),
    );
  } else if (Platform.isIOS) {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showIOSAlertDialog(context, onPublish, onSaveDraft),
    );
  }
}

AlertDialog _showAndroidAlertDialog(
    BuildContext context, VoidCallback onPublish, VoidCallback onSaveDraft) {
  return AlertDialog(
    content: SizedBox(
      height: 210,
      child: Column(
        children: [
          const Text(
            '¿Quieres publicar la propuesta?',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 22),
          Column(children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  onPublish();
                  Navigator.pop(context);
                },
                child: const Text('Publicar'),
              ),
            ),
            TextButton(
                onPressed: () {
                  onSaveDraft();
                  Navigator.pop(context);
                },
                child: const Text('Guardar como borrador')),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
          ])
        ],
      ),
    ),
  );
}

CupertinoAlertDialog _showIOSAlertDialog(
    BuildContext context, VoidCallback onPublish, VoidCallback onSaveDraft) {
  return CupertinoAlertDialog(
    content: SizedBox(
      height: 232,
      child: Column(
        children: [
          const Text(
            '¿Quieres publicar la propuesta?',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Column(children: [
            CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  onPublish();
                  Navigator.pop(context);
                },
                child: const Text('Publicar')),
            CupertinoButton(
                onPressed: () {
                  onSaveDraft();
                  Navigator.pop(context);
                },
                child: const Text('Guardar como borrador')),
            CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
          ])
        ],
      ),
    ),
  );
}
