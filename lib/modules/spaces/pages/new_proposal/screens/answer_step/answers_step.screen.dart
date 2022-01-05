import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/add_proposal_answer.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_answer.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_list.widget.dart';
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
  late final List<Widget> answers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ProposalAnswerWidget(isVisible: true, title: 'A favor')),
        Expanded(
            child: ProposalAnswerWidget(isVisible: true, title: 'En contra')),

        // Expanded(
        //   child: ProposalListWidget(title: '', answers: answers),
        // ),
        Expanded(child: AddProposalAnswer(add: addNewProposal)),
        Expanded(flex: 5, child: Container()),
        Expanded(
          child: BigButton(
            text: 'Crear',
            onPressed: () => widget.createProposal(),
          ),
        )
      ],
    );
  }

  Widget addNewProposal() {
    return ProposalAnswerWidget(isVisible: true);
  }
}
