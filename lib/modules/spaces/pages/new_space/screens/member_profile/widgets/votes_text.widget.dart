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
        Text('$created', style: TextStyle(fontSize: 18, color: Colors.black)),
        Text(' creadas   '),
        Text('$votes', style: TextStyle(fontSize: 18, color: Colors.black)),
        Text(' votos'),
      ],
    );
  }
}
