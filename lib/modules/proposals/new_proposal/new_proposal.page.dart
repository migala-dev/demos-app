import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/new_proposal/services/new_proposal_content.service.model.dart';
import 'package:demos_app/modules/proposals/new_proposal/modals/open_publish_proposal_dialog.dart';
import 'package:demos_app/modules/proposals/new_proposal/modals/open_save_proposal_draft_dialog.modal.dart';
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
    return WillPopScope(
      onWillPop: () async {
        if (currentStep == NewProposalScreenEnum.content) {
          return await handlePopInFirstStep();
        }

        goToContent();
        return false;
      },
      child: Scaffold(
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
      ),
    );
  }

  Future<bool> handlePopInFirstStep() async {
    if (NewProposalContentService().isEmpty()) {
      return true;
    }

    final optionSelected =
        await openSaveProposalDraftDialog(context, onSaveDraft: () {});
    if (optionSelected == 'cancel') {
      return false;
    }

    return true;
  }

  void goToContent() =>
      setState(() => currentStep = NewProposalScreenEnum.content);

  Widget getCurrentScreen() {
    return currentStep == NewProposalScreenEnum.content
        ? ContentStepScreen(goToNextStep: goToNextStep)
        : AnswersStepScreen(createProposal: createProposal);
  }

  void goToNextStep() =>
      setState(() => currentStep = NewProposalScreenEnum.answers);

  void createProposal() {
    openPublishProposalDialog(context, onPublish: () {
      Navigator.pop(context);
    }, onSaveDraft: () {
      Navigator.pop(context);
    });
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
