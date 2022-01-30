import 'package:demos_app/modules/proposals/pages/proposal_form/screens/content_step/content_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/options_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/services/new_proposal_content.service.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';

import 'modals/open_publish_proposal_dialog.dart';
import 'modals/open_save_proposal_draft_dialog.modal.dart';

class NewProposalScreen extends StatefulWidget {
  const NewProposalScreen({Key? key}) : super(key: key);

  @override
  _NewProposalScreenState createState() => _NewProposalScreenState();
}

enum NewProposalScreenEnum { content, answers }

class _NewProposalScreenState extends State<NewProposalScreen> {
  ManifestoOptionType optionType = ManifestoOptionType.inFavorOrOpposing;
  // late List<ManifestoOptionWidget> options = List<ManifestoOptionWidget>;
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
        await openSaveProposalDraftDialog(context, onSaveDraft: saveDraft);
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
        : OptionsStepScreen(createProposal: createProposal);
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

  void saveDraft() async {
    final spaceId = SpaceBloc().state!.spaceId!;
    final title = NewProposalContentService().title;
    final content = NewProposalContentService().content;

    await ProposalService().createNewProposalDraft(
        spaceId, title, content, ManifestoOptionType.inFavorOrOpposing, []);

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
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
