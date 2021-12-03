import 'package:flutter/material.dart';

class PoweredByMigala extends StatelessWidget {
  const PoweredByMigala({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            children: const [
              Text(
                'powered by',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text('Migala',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }
}
