import 'package:flutter/material.dart';

class ProposalCardInfo extends StatelessWidget {
  final Icon Function(double size, MaterialColor color) getIcon;
  final String title;
  final String content;

  const ProposalCardInfo(
      {Key? key,
      required this.getIcon,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0),
          child: getIcon(28.0, Colors.grey),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 16,),
            )
          ],
        )
      ],
    );
  }
}
