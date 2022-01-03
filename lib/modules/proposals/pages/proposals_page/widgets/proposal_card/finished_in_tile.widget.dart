import 'package:flutter/material.dart';

class FinishedInTile extends StatelessWidget {
  final String manifestoId;

  const FinishedInTile({Key? key, required this.manifestoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, color: Colors.grey),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TERMINA EN:',
              style: TextStyle(color: Colors.grey),
            ),
            FutureBuilder(
              future: getDaysLeft(),
              initialData: '',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return Text(
                  '${snapshot.data} días',
                  style: const TextStyle(fontSize: 18),
                );
              },
            )
          ],
        )
      ],
    );
  }

  Future<String> getDaysLeft() async {
    return '6';
  }
}
