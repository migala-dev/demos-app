import 'package:flutter/material.dart';

class DemosLogo extends StatelessWidget {
  const DemosLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Powered by Migala               '),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 150,
          width: 150,
          color: Colors.grey,
        ),
        const Text(
          'DÊMOS',
          style: TextStyle(fontSize: 45),
        ),
        const Text('Democratiza tus espacios de trabajo')
      ],
    );
  }
}
