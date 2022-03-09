import 'package:flutter/material.dart';

class BigOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BigOutlinedButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            const BoxConstraints.tightFor(width: double.infinity, height: 60),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: Colors.blue),
            ),
            onPressed: onPressed,
            child: Text(
              text.toUpperCase(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            )));
  }
}
