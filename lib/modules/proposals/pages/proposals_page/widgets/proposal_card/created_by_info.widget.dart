import 'package:flutter/material.dart';

class CreatedByChip extends StatelessWidget {
  const CreatedByChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey[400]),
        ),
        const SizedBox(width: 10),
        const Text('Erik Ivanov', style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
