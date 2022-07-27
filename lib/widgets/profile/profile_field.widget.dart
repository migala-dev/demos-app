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

import 'package:demos_app/config/custom-icons/demos_icons_icons.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? child;
  final IconData icon;
  final bool editable;
  final VoidCallback? onEdit;
  final String placeholder;
  final List<WidgetValidator>? editableButtonValidators;

  const ProfileField(
      {Key? key,
      required this.title,
      required this.icon,
      this.value,
      this.editable = false,
      this.placeholder = 'Vacío',
      this.onEdit,
      this.editableButtonValidators,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.only(top: 6.0),
        child: Icon(
          icon,
          size: 32,
          color: primaryColorLight,
        ),
      ),
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.all(0),
      trailing: editable
          ? SafeWidgetValidator(
              validators: editableButtonValidators,
              child: IconButton(
                icon: Icon(
                  DemosIcons.pencil,
                  color: onEdit == null ? Colors.grey : secondaryColorDark,
                ),
                onPressed: onEdit,
              ))
          : const SizedBox(
              height: 14,
              width: 14,
            ),
      title: Text(
        title,
        style: const TextStyle(
            color: primaryColor, fontSize: 14, fontFamily: 'Rubik'),
      ),
      subtitle: child == null
          ? hasValue()
              ? getValueLabel()
              : getWithoutValueLabel()
          : child!,
      shape: const Border(bottom: BorderSide()),
    );
  }

  bool hasValue() {
    return value != null && value != '';
  }

  Widget getValueLabel() {
    return Text(value ?? '',
        style: const TextStyle(color: Colors.black, fontSize: 18));
  }

  Widget getWithoutValueLabel() {
    return Text(placeholder,
        style: const TextStyle(color: Colors.black26, fontSize: 18));
  }
}
