/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
