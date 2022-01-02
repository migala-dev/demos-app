import 'package:flutter/material.dart';

class ProposalHistoryChipButton extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function() onTap;

  const ProposalHistoryChipButton(
      {Key? key,
      required this.text,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return GestureDetector(
        onTap: onTap,
        child: Text(text,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Text(text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          )),
    );
  }
}
