import 'package:flutter/material.dart';

class RepliesCountButton extends StatelessWidget {
  final VoidCallback onTap;
  final int repliesCount;
  const RepliesCountButton(
      {Key? key, required this.onTap, required this.repliesCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 20,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          '$repliesCount respuestas',
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }
}
