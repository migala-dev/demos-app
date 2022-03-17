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
import 'package:demos_app/core/enums/space_role.enum.dart';

class SelectRoleModal extends StatelessWidget {
  const SelectRoleModal(
      {Key? key, required this.updateRole, required this.currentRole})
      : super(key: key);

  final Function(SpaceRole) updateRole;
  final SpaceRole currentRole;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Selecciona un nuevo rol',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))),
        ...SpaceRole.values
            .map((SpaceRole spaceRole) => ListTile(
                  leading: _getCheckCurrentRoleLeading(spaceRole),
                  title: Text(getSpaceRoleName(spaceRole)),
                  onTap: () async {
                    if (currentRole != spaceRole) {
                      await updateRole(spaceRole);
                    }
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ],
    );
  }

  Widget? _getCheckCurrentRoleLeading(SpaceRole spaceRole) {
    if (currentRole == spaceRole) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }

    return const SizedBox();
  }
}
