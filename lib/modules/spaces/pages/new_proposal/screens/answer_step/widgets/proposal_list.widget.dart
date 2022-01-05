import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_answer.widget.dart';
import 'package:flutter/material.dart';

class ProposalListWidget extends StatelessWidget {
  const ProposalListWidget(
      {Key? key, required this.title, required this.answers})
      : super(key: key);

  final String title;
  final List<Widget> answers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: answers.length,
      itemBuilder: (context, index) {
        Widget answer = answers[index];
        return ProposalAnswerWidget(
          isVisible: true,
          title: title,
        );
      },
    );
  }

  void addNewProposal() {}
}
