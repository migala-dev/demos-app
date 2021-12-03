import 'package:flutter/material.dart';

class VotesText extends StatelessWidget {
  const VotesText({Key? key, this.created = 0, this.votes = 0})
      : super(key: key);

  final int created;
  final int votes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$created',
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        const Text(' creadas   '),
        Text('$votes',
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        const Text(' votos'),
      ],
    );
  }
}
