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

import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

Future<String?> openUpdateStringFieldModal(
  BuildContext context, {
  required String title,
  required String hintText,
  String? initialValue,
  String? Function(String?)? validator,
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
    validator: validator,
    maxLines: 1,
    autoFocus: true,
    barrierDismissible: true,
    textCapitalization: TextCapitalization.words,
  );
}
