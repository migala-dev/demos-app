import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool disabled;

  const BigButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(width: double.infinity, height: 60),
        child: isLoading ? getLoadingButton() : getMainButton(context));
  }

  Widget getLoadingButton() {
    return ElevatedButton(
        onPressed: null,
        child: CircularProgressIndicator(
          color: Colors.black,
        ));
  }

  Widget getMainButton(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color backgroundColor = disabled ? Colors.grey : primaryColor;

    return ElevatedButton(
        onPressed: () {
          if (!disabled) {
            onPressed();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor)
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 20),
        ));
  }
}
