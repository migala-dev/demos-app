import 'package:flutter/material.dart';

class LeftBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LeftBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back))
      ],
    );
  }
}
