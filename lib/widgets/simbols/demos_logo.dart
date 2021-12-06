import 'package:flutter/material.dart';

class DemosLogo extends StatelessWidget {
  const DemosLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.65;
    return Column(
      children: [
      Image(
        image: const AssetImage('assets/images/demos-logo.png'),
        width: width,
        height: width,
        fit: BoxFit.cover)
      ],
    );
  }
}
