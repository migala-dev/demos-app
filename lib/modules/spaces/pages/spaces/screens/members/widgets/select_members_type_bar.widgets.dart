import 'package:demos_app/modules/spaces/pages/spaces/screens/members/widgets/member_type_chip_button.widget.dart';
import 'package:flutter/material.dart';

class SelectMembersTypeBar extends StatelessWidget {
  final String all = 'Todos';
  final String leader = 'Jefe';
  final String administrator = 'Administrador';
  final String invitations = 'Invitaciones';

  final String selected;
  final Function onSelectedMembersChange;
  const SelectMembersTypeBar({
    Key? key,
    required this.selected,
    required this.onSelectedMembersChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MemberTypeChipButton(
          text: all,
          selected: selected == all,
          onTap: onSelectedMembersChange,
        ),
        MemberTypeChipButton(
          text: leader,
          selected: selected == leader,
          onTap: onSelectedMembersChange,
        ),
        MemberTypeChipButton(
          text: administrator,
          selected: selected == administrator,
          onTap: onSelectedMembersChange,
        ),
        MemberTypeChipButton(
          text: invitations,
          selected: selected == invitations,
          onTap: onSelectedMembersChange,
        ),
      ],
    );
  }
}
