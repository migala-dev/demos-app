import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_editor.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_editors/get_proposal_form_editor.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/content_step/content_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/options_step.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, state) {
        final proposalFormEditor = getProposalFormEditorFromType(state.type);

        return WillPopScope(
          onWillPop: () => onWillPop(proposalFormEditor),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: Text(proposalFormEditor.editProposalTitle),
                actions: proposalFormEditor.getAppBarActions()),
            body: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      child: getCurrentScreen(proposalFormEditor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getCurrentScreen(ProposalFormEditor proposalFormEditor) {
    return currentStep == ProposalFormStepEnum.content
        ? ContentStepScreen(goToNextStep: goToNextStep)
        : OptionsStepScreen(
            confirmPublishProposal: () =>
                proposalFormEditor.openPublishDialog(context),
            publishButtonLabel: proposalFormEditor.publishButtonLabel,
          );
  }

  void goToNextStep() =>
      setState(() => currentStep = ProposalFormStepEnum.options);

  void goToContent() =>
      setState(() => currentStep = ProposalFormStepEnum.content);

  Future<bool> onWillPop(ProposalFormEditor proposalFormEditor) async {
    ProposalFormView proposalFormView = ProposalFormBloc().state;
    switch (currentStep) {
      case ProposalFormStepEnum.content:
        if (proposalFormView.change) {
          return await proposalFormEditor.openOnWillPopDialog(context);
        }
        return true;
      case ProposalFormStepEnum.options:
        goToContent();
        return false;
    }
  }
}
