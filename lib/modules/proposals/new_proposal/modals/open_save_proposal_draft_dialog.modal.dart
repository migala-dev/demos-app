import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> openSaveProposalDraftDialog(BuildContext context,
    {required VoidCallback onSaveDraft}) async {
  if (Platform.isAndroid) {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showAndroidAlertDialog(context, onSaveDraft),
    );
  } else if (Platform.isIOS) {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          _showIOSAlertDialog(context, onSaveDraft),
    );
  }
}

AlertDialog _showAndroidAlertDialog(
    BuildContext context, VoidCallback onSaveDraft) {
  return AlertDialog(
    content: SizedBox(
      height: 210,
      child: Column(
        children: [
          const Text(
            '¿Deseas guardar esta propuesta como borrador?',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 22),
          Column(children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  onSaveDraft();
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No')),
            TextButton(
                onPressed: () => Navigator.pop(context, 'cancel'),
                child: const Text('Cancelar')),
          ])
        ],
      ),
    ),
  );
}

CupertinoAlertDialog _showIOSAlertDialog(
    BuildContext context, VoidCallback onSaveDraft) {
  return CupertinoAlertDialog(
    content: SizedBox(
      height: 262,
      child: Column(
        children: [
          const Text(
            '¿Deseas guardar esta propuesta como borrador?',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Column(children: [
            CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  onSaveDraft();
                  Navigator.pop(context);
                },
                child: const Text('Guardar')),
            CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No')),
            CupertinoButton(
                onPressed: () => Navigator.pop(context, 'cancel'),
                child: const Text('Cancelar')),
          ])
        ],
      ),
    ),
  );
}
