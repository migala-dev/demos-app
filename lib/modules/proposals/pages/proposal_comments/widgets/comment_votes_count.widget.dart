import 'package:flutter/material.dart';

class CommentVotesCount extends StatelessWidget {
  final int votesInFavor;
  final int votesInOpposing;
  const CommentVotesCount(
      {Key? key, required this.votesInFavor, required this.votesInOpposing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int votesCount = votesInFavor - votesInOpposing;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            const Icon(Icons.arrow_upward, size: 15, color: Colors.grey),
            Text(votesCount > 0 ? '$votesCount' : ''),
          ]),
          const SizedBox(width: 5),
          Row(children: [
            const Icon(Icons.arrow_downward, size: 15, color: Colors.grey),
            Text(votesCount < 0 ? '${-votesCount}' : '')
          ]),
        ],
      ),
    );
  }
}
