import 'package:flutter/material.dart';

class VoteCounter extends StatelessWidget {
  final String manifestoId;

  const VoteCounter({Key? key, required this.manifestoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.how_to_vote_rounded, color: Colors.grey),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'VOTOS:',
              style: TextStyle(color: Colors.grey),
            ),
            FutureBuilder(
              future: getVotesProgress(),
              initialData: '',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return Text(
                  snapshot.data!,
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Future<String> getVotesProgress() async {
    return '12/20';
  }
}
