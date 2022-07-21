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

import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_chip_button.widget.dart';

class MemberTypeFilter extends StatelessWidget {
  final MemberType selected;
  final Function onFilteredMembersChange;
  const MemberTypeFilter({
    Key? key,
    required this.selected,
    required this.onFilteredMembersChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        MemberTypeChipButton(
          text: 'Todos',
          type: MemberType.all,
          selected: selected == MemberType.all,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Trabajadores',
          type: MemberType.worker,
          selected: selected == MemberType.worker,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Administradores',
          type: MemberType.administrator,
          selected: selected == MemberType.administrator,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Representates',
          type: MemberType.representative,
          selected: selected == MemberType.representative,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Invitaciones',
          type: MemberType.invited,
          selected: selected == MemberType.invited,
          onTap: onFilteredMembersChange,
        ),
      ],
    );
  }
}
