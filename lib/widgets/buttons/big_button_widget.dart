import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const BigButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(width: double.infinity, height: 60),
        child: isLoading ? getLoadingButton() : getMainButton());
  }

  Widget getLoadingButton() {
    return ElevatedButton(
        onPressed: null,
        child: CircularProgressIndicator(
          color: Colors.black,
        ));
  }

  Widget getMainButton() {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 20),
        ));
  }
}
