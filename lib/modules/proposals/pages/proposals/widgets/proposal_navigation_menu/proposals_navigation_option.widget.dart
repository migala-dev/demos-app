import 'package:flutter/material.dart';

class ProposalsNavigationOption extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function() onTap;

  const ProposalsNavigationOption(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return GestureDetector(
        onTap: onTap,
        child: Text(title,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Text(title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          )),
    );
  }
}
