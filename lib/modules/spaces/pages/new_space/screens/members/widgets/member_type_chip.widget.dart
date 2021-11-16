import 'package:flutter/material.dart';

class MemberTypeChip extends StatelessWidget {
  final Color backgroundColor;
  final Color accentColor;

  const MemberTypeChip(
      {Key? key,
      required this.text,
      required this.backgroundColor,
      required this.accentColor})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(color: accentColor, fontWeight: FontWeight.w300),
      ),
      backgroundColor: backgroundColor,
      side: BorderSide(color: accentColor, width: 0.5),
    );
  }
}
