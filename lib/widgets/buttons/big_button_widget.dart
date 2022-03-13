import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;

  const BigButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.disabled = false,
      this.backgroundColor,
      this.textColor
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            const BoxConstraints.tightFor(width: double.infinity, height: 52),
        child: isLoading ? getLoadingButton() : getMainButton(context));
  }

  Widget getLoadingButton() {
    return const ElevatedButton(
        onPressed: null,
        child: CircularProgressIndicator(
          color: Colors.black,
        ));
  }

  Widget getMainButton(BuildContext context) {
    Color color = backgroundColor ?? Theme.of(context).primaryColor;
    Color finalBackgroundColor = disabled ? Colors.grey : color;

    return ElevatedButton(
        onPressed: () {
          if (!disabled) {
            onPressed();
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(finalBackgroundColor)),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 16, color: textColor),
        ));
  }
}
