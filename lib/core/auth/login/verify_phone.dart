import 'package:flutter/material.dart';

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Verify your phone'),
        ),
      ),
    );
  }
}
