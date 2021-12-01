import 'package:flutter/material.dart';

class AsyncText extends StatefulWidget {
  final Future<String> Function() getText;

  const AsyncText(this.getText, {Key? key}) : super(key: key);

  @override
  _AsyncTextState createState() => _AsyncTextState();
}

class _AsyncTextState extends State<AsyncText> {
  String? text;

  void getAsyncText() async {
    String newText = await widget.getText();
    setState(() {
      text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      getAsyncText();
    }
    return Text(text ?? '');
  }
}
