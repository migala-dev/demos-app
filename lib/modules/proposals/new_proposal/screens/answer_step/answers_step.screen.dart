import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/add_proposal_answer.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_answer.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/answers_list.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class AnswersStepScreen extends StatefulWidget {
  final VoidCallback createProposal;

  const AnswersStepScreen({Key? key, required this.createProposal})
      : super(key: key);

  @override
  _AnswersStepScreenState createState() => _AnswersStepScreenState();
}

class _AnswersStepScreenState extends State<AnswersStepScreen> {
  late final List<Widget> answers;
  final List<String> items = ['Votación a favor/en contra', 'Opción multiple'];
  String? value = 'Votación a favor/en contra';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: items.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(
                () {
                  this.value = value;
                  if (this.value == 'Votación a favor/en contra') {
                    isVisible = !isVisible;
                  } else if (this.value == 'Opción multiple') {
                    isVisible = !isVisible;
                  }
                },
              );
            },
            value: value,
          ),
        ),
        const SizedBox(height: 24),
        const Text('Opciones', style: TextStyle(color: Colors.grey)),
        Visibility(
            visible: isVisible,
            child: Expanded(child: ProposalAnswerWidget(title: 'A favor'))),
        Expanded(child: ProposalAnswerWidget(title: 'En contra')),
        Expanded(flex: 4, child: Container()),
        Expanded(
          child: BigButton(
            text: 'Crear',
            onPressed: () => widget.createProposal(),
          ),
        )
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
