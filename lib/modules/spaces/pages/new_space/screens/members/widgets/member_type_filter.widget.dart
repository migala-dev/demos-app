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
        const SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Trabajadores',
          type: MemberType.worker,
          selected: selected == MemberType.worker,
          onTap: onFilteredMembersChange,
        ),
        const SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Administradores',
          type: MemberType.administrator,
          selected: selected == MemberType.administrator,
          onTap: onFilteredMembersChange,
        ),
        const SizedBox(width: 10),
        MemberTypeChipButton(
          text: 'Representates',
          type: MemberType.representative,
          selected: selected == MemberType.representative,
          onTap: onFilteredMembersChange,
        ),
        const SizedBox(width: 10),
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
