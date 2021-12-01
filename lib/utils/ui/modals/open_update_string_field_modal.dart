import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

Future<String?> openUpdateStringFieldModal(
  BuildContext context, {
  required String title,
  required String hintText,
  String? initialValue,
}) async {
  return await prompt(
    context,
    title: Text(title),
    initialValue: initialValue,
    textOK: const Text('Guardar'),
    textCancel: const Text(
      'Cancelar',
      style: TextStyle(color: Colors.grey),
    ),
    hintText: hintText,
    maxLines: 1,
    autoFocus: true,
    barrierDismissible: true,
    textCapitalization: TextCapitalization.words,
  );
}
