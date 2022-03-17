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

import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_representant_alert.widget.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:flutter/material.dart';

class NoProposals extends StatelessWidget {
  NoProposals({Key? key}) : super(key: key);
  final color = Colors.grey.shade500;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.how_to_vote_outlined, size: 135, color: color),
        const SizedBox(height: 10),
        Text('Sin propuestas por el momento', style: TextStyle(color: color)),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const SafeWidgetMemberValidator(
              roles: [SpaceRole.admin],
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: NoRepresentantAlert())),
        )
      ],
    );
  }
}
