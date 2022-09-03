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
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/widgets/safe_member_validator.widget.dart';
import 'package:flutter/material.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: SafeWidgetMemberValidator(
        roles: const [SpaceRole.admin, SpaceRole.worker],
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(DemosIcons.add),
        ),
      ),
    );
  }
}
