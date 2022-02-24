import 'package:flutter/material.dart';

class CommentsTile extends StatelessWidget {
  final int numberOfComments;
  final VoidCallback onTap;

  const CommentsTile(
      {Key? key, required this.numberOfComments, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ))),
        child: Center(
            child: Text(
          '($numberOfComments) Comentarios',
          style: const TextStyle(color: Colors.grey, fontSize: 18),
        )),
      ),
    );
  }
}
