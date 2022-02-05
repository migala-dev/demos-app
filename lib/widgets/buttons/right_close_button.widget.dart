import 'package:flutter/material.dart';

class RightCloseButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RightCloseButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: onPressed, icon: const Icon(Icons.close))
      ],
    );
  }
}
