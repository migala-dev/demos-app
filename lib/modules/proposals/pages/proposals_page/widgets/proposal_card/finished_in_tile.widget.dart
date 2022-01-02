import 'package:flutter/material.dart';

class FinishedInTile extends StatelessWidget {
  const FinishedInTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, color: Colors.grey),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'TERMINA EN:',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '5 días',
              style: TextStyle(fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}
