import 'package:flutter/material.dart';

class NoProposals extends StatelessWidget {
  NoProposals({Key? key}) : super(key: key);
  final color = Colors.grey.shade500;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.how_to_vote_outlined, size: 135, color: color),
        const SizedBox(height: 10),
        Text('Sin propuestas por el momento', style: TextStyle(color: color))
      ],
    );
  }
}
