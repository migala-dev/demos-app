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
      physics: BouncingScrollPhysics(),
      children: [
        MemberTypeChipButton(
          text: 'Todos',
          type: MemberType.ALL,
          selected: selected == MemberType.ALL,
          onTap: onFilteredMembersChange,
        ),
        SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Trabajadores',
          type: MemberType.WORKER,
          selected: selected == MemberType.WORKER,
          onTap: onFilteredMembersChange,
        ),
        SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Administradores',
          type: MemberType.ADMINISTRATOR,
          selected: selected == MemberType.ADMINISTRATOR,
          onTap: onFilteredMembersChange,
        ),
        SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Representates',
          type: MemberType.REPRESENTATIVE,
          selected: selected == MemberType.REPRESENTATIVE,
          onTap: onFilteredMembersChange,
        ),
        SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Invitaciones',
          type: MemberType.INVITED,
          selected: selected == MemberType.INVITED,
          onTap: onFilteredMembersChange,
        ),
      ],
    );
  }
}
