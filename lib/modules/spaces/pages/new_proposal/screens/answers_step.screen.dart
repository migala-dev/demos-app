import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

class AnswersStepScreen extends StatefulWidget {
  final VoidCallback createProposal;

  const AnswersStepScreen({Key? key, required this.createProposal})
      : super(key: key);

  @override
  _AnswersStepScreenState createState() => _AnswersStepScreenState();
}

class _AnswersStepScreenState extends State<AnswersStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 8, child: Container()),
        Expanded(
          child: BigButton(
            text: 'Crear',
            onPressed: () => widget.createProposal(),
          ),
        )
      ],
    );
  }
}
