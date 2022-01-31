import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/modals/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/content_step/content_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/options_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

import 'modals/open_publish_proposal_dialog.dart';
import 'modals/open_save_proposal_draft_dialog.modal.dart';

class ProposalFormScreen extends StatefulWidget {
  const ProposalFormScreen({Key? key}) : super(key: key);

  @override
  _ProposalFormScreenState createState() => _ProposalFormScreenState();
}

enum ProposalFormStepEnum { content, options }

class _ProposalFormScreenState extends State<ProposalFormScreen> {
  ProposalFormStepEnum currentStep = ProposalFormStepEnum.content;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ProposalFormView proposalFormView = ProposalFormBloc().state;
        switch (currentStep) {
          case ProposalFormStepEnum.content:
            if (proposalFormView.isNew && proposalFormView.change) {
              return await askForCreateADraftCreation();
            }
            return true;
          case ProposalFormStepEnum.options:
            goToContent();
            return false;
        }
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

  Future<bool> askForCreateADraftCreation() async {
    final optionSelected =
        await openSaveProposalDraftDialog(context, onSaveDraft: saveDraft);

    return optionSelected != 'cancel';
  }

  void goToContent() =>
      setState(() => currentStep = ProposalFormStepEnum.content);

  Widget getCurrentScreen() {
    return currentStep == ProposalFormStepEnum.content
        ? ContentStepScreen(goToNextStep: goToNextStep)
        : OptionsStepScreen(createProposal: createProposal);
  }

  void goToNextStep() =>
      setState(() => currentStep = ProposalFormStepEnum.options);

  void createProposal() {
    openPublishProposalDialog(context, onPublish: () {
      Navigator.pop(context);
    }, onSaveDraft: () {
      saveDraft();
      Navigator.pop(context);
    });
  }

  void saveDraft() async {
    final spaceId = SpaceBloc().state!.spaceId!;
    ProposalFormView proposalFormView = ProposalFormBloc().state;

    await ProposalService().createNewProposalDraft(spaceId, proposalFormView);

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
