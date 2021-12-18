import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

class ContentStepScreen extends StatefulWidget {
  final VoidCallback goToNextStep;

  const ContentStepScreen({Key? key, required this.goToNextStep})
      : super(key: key);

  @override
  _ContentStepScreenState createState() => _ContentStepScreenState();
}

class _ContentStepScreenState extends State<ContentStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 8, child: Container()),
        Expanded(
          child: BigButton(
            text: 'Continuar',
            onPressed: () => widget.goToNextStep(),
          ),
        )
      ],
    );
  }
}
