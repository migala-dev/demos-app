import 'package:flutter/material.dart';

class DemosLogo extends StatelessWidget {
  const DemosLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Powered by Migala               '),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 150,
          width: 150,
          color: Colors.grey,
        ),
        Text(
          'DÊMOS',
          style: TextStyle(fontSize: 45),
        ),
        Text('Democratiza tus espacios de trabajo')
      ],
    );
  }
}
