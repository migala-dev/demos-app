import 'package:flutter/material.dart';

class VoteCounter extends StatelessWidget {
  const VoteCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.how_to_vote_rounded, color: Colors.grey),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'VOTOS:',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '12/20',
              style: TextStyle(fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}
