import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/new_proposal/screens/answer_step/answers_step.screen.dart';
import 'package:demos_app/modules/proposals/new_proposal/screens/content_step/content_step.screen.dart';

class NewProposalScreen extends StatefulWidget {
  const NewProposalScreen({Key? key}) : super(key: key);

  @override
  _NewProposalScreenState createState() => _NewProposalScreenState();
}

enum NewProposalScreenEnum { content, answers }

class _NewProposalScreenState extends State<NewProposalScreen> {
  NewProposalScreenEnum currentStep = NewProposalScreenEnum.content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: getAppBarTitle()),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: getCurrentScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCurrentScreen() {
    return currentStep == NewProposalScreenEnum.content
        ? ContentStepScreen(goToNextStep: goToNextStep)
        : AnswersStepScreen(createProposal: createProposal);
  }

  void goToNextStep() =>
      setState(() => currentStep = NewProposalScreenEnum.answers);

  void createProposal() => Navigator.pop(context);

  Column getAppBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nueva propuesta'),
        Text(
          'Paso ${currentStep.index + 1} de 2',
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}
