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

import 'package:demos_app/config/themes/main_theme.dart';
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
      height: 54 + options.length * 45,
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
                        style:
                            const TextStyle(color: primaryColor, fontSize: 14.0),
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
      height: 20 + options.length * 70,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Column(children: [
            ...options.map((option) {
              if (option.isPrimary) {
                return CupertinoButton(
                    color: primaryColor,
                    onPressed: () {
                      option.onPressed();
                      Navigator.pop(context, option);
                    },
                    child: Text(option.label));
              }
              return CupertinoButton(
                  onPressed: () {
                    option.onPressed();
                    Navigator.pop(context, option);
                  },
                  child: Text(option.label, style: 
                            const TextStyle(color: primaryColor, fontSize: 18.0),));
            }),
          ])
        ],
      ),
    ),
  );
}
