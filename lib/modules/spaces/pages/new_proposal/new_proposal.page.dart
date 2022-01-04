import 'package:demos_app/core/bloc/manifestos/manifestos_bloc.dart';
import 'package:demos_app/core/enums/proposal/proposal_option_type.enum.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answers_step.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/content_step.screen.dart';
import 'package:flutter/material.dart';

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

  void createProposal() {
    // TODO: cambiar propuesta ficticia por llamada a API
    ManifestosBloc().add(ManifestoAdded(Manifesto(
      '123',
      'Primera Propuesta',
      '0',
      '4c2965c9-e5be-4b91-b6d7-db29956334c8',
      ProposalOptionType.aFavorEnContra,
      '0',
    )));

    Navigator.pop(context);
  }

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
