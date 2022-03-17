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

  return null;
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
