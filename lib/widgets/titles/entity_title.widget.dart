import 'package:flutter/material.dart';

class EntityTitle extends StatelessWidget {
  final String name;
  final String type;
  const EntityTitle({Key? key, required this.name, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type),
        Text(
          name,
          style: const TextStyle(fontSize: 40),
        )
      ],
    );
  }
}
