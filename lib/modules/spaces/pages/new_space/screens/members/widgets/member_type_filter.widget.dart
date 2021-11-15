import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/utils/labels.dart';
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
          text: all,
          selected: selected.label == all,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: leader,
          selected: selected.label == leader,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: administrator,
          selected: selected.label == administrator,
          onTap: onFilteredMembersChange,
        ),
        MemberTypeChipButton(
          text: invitations,
          selected: selected.label == invitations,
          onTap: onFilteredMembersChange,
        ),
      ],
    );
  }
}
