import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_chip.widget.dart';

class MemberTypeChipButton extends StatelessWidget {
  final MemberType type;
  final String text;
  final bool selected;
  final Function onTap;

  const MemberTypeChipButton({
    Key? key,
    required this.text,
    this.selected = false,
    required this.onTap,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = selected ? Colors.grey : Colors.transparent;
    Color accentColor = selected ? Colors.white : Colors.blue;

    return GestureDetector(
      onTap: () => onTap(type),
      child: MemberTypeChip(
        text: text,
        accentColor: accentColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
