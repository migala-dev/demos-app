import 'package:flutter/material.dart';

class ReplyButton extends StatelessWidget {
  final VoidCallback onTap;
  const ReplyButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: const [
          Icon(
            Icons.reply_outlined,
            color: Colors.grey,
          ),
          SizedBox(width: 2),
          Text('Responder'),
        ],
      ),
    );
  }
}
