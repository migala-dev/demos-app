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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MemberTypeChipButton(
          text: 'Todos',
          type: MemberType.ALL,
          selected: selected == MemberType.ALL,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Trabajadores',
          type: MemberType.WORKER,
          selected: selected == MemberType.WORKER,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: 'Admins',
          type: MemberType.ADMINISTRATOR,
          selected: selected == MemberType.ADMINISTRATOR,
          onTap: onFilteredMembersChange,
        ),
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
