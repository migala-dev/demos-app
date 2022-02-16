import 'package:flutter/material.dart';

class CommentVotesCount extends StatelessWidget {
  final int votesInFavor;
  final int votesInOpposing;
  const CommentVotesCount(
      {Key? key, required this.votesInFavor, required this.votesInOpposing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color votesInFavorArrowColor =
        votesInFavor > 0 ? Colors.green : Colors.grey;

    final Color votesInOpposingArrowColor =
        votesInOpposing > 0 ? Colors.red : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Icon(Icons.arrow_upward, size: 15, color: votesInFavorArrowColor),
            Text('$votesInFavor'),
          ]),
          const SizedBox(width: 5),
          Row(children: [
            Icon(Icons.arrow_downward,
                size: 15, color: votesInOpposingArrowColor),
            Text('$votesInOpposing')
          ]),
        ],
      ),
    );
  }
}
