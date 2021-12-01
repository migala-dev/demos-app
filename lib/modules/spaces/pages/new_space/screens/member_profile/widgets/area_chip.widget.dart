import 'package:flutter/material.dart';

class AreaChip extends StatelessWidget {
  const AreaChip(
      {Key? key,
      required this.color,
      required this.text,
      this.borderRadiusSize = 100})
      : super(key: key);

  final Color color;
  final String text;
  final double borderRadiusSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      width: text.length * 12 + 10,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusSize)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: color),
      ),
    );
  }
}
