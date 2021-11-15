import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:flutter/material.dart';

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
    if (selected) return _getSelectedChip();
    return GestureDetector(
      onTap: () => onTap(type),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.blue, width: 0.5),
      ),
    );
  }

  Chip _getSelectedChip() {
    return Chip(
      label: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      backgroundColor: Colors.grey,
      side: BorderSide(color: Colors.grey, width: 0.5),
    );
  }
}
