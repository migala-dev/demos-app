import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/content_step/content_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/options_step.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/widgets/popup_proposal_form_menu_options.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

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
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: getAppBarTitle(), actions: getAppBarActions()),
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

  List<Widget>? getAppBarActions() {
    final isNewDraft = ProposalFormBloc().state.isNew;
    if (!isNewDraft) {
      return [PopupProposalFormMenuOptions()];
    }
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

  Widget getCurrentScreen() {
    return currentStep == ProposalFormStepEnum.content
        ? ContentStepScreen(goToNextStep: goToNextStep)
        : OptionsStepScreen(confirmPublishProposal: confirmPublishProposal);
  }

  void goToNextStep() =>
      setState(() => currentStep = ProposalFormStepEnum.options);

  void confirmPublishProposal() {
    String title = '¿Quieres publicar la propuesta?';
    List<DialogOption> options = [
      DialogOption(label: 'Publicar', onPressed: publish, isPrimary: true),
      getDraftOption()
    ];

    openCustomConfirmDialog(context, title, options);
  }

  void publish() async {
    String spaceId = SpaceBloc().state!.spaceId!;
    ProposalFormView proposalFormView = ProposalFormBloc().state;

    if (proposalFormView.proposalId == null) {
      await ProposalService()
          .createAndPublishProposal(spaceId, proposalFormView);
    } else {
      await ProposalService().publishProposalDraft(
          spaceId, proposalFormView.proposalId!, proposalFormView);
    }

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
    Navigator.pop(context);
  }

  DialogOption getDraftOption() {
    ProposalFormView proposalFormView = ProposalFormBloc().state;
    String label = proposalFormView.proposalId == null
        ? 'Guardar como borrador'
        : 'Actualizar borrador';
    return DialogOption(
        label: label,
        onPressed: () {
          saveDraft();
          Navigator.pop(context);
        });
  }

  Future<bool> onWillPop() async {
    ProposalFormView proposalFormView = ProposalFormBloc().state;
    switch (currentStep) {
      case ProposalFormStepEnum.content:
        if (proposalFormView.change) {
          return await askForCreateOrUpdateDraft();
        }
        return true;
      case ProposalFormStepEnum.options:
        goToContent();
        return false;
    }
  }

  Future<bool> askForCreateOrUpdateDraft() async {
    ProposalFormView proposalFormView = ProposalFormBloc().state;
    String title = proposalFormView.proposalId == null
        ? '¿Deseas guardar esta propuesta como borrador?'
        : '¿Deseas guardar los cambios?';
    List<DialogOption> options = [
      DialogOption(label: 'Guardar', onPressed: saveDraft, isPrimary: true),
      DialogOption(label: 'No', onPressed: () {}),
    ];

    DialogOption? optionSelected =
        await openCustomConfirmDialog(context, title, options);

    return optionSelected != dialogCancelOption;
  }

  void goToContent() =>
      setState(() => currentStep = ProposalFormStepEnum.content);

  void saveDraft() async {
    final spaceId = SpaceBloc().state!.spaceId!;
    ProposalFormView proposalFormView = ProposalFormBloc().state;

    if (proposalFormView.proposalId == null) {
      await ProposalService().createNewProposalDraft(spaceId, proposalFormView);
    } else {
      await ProposalService().updateProposalDraft(
          spaceId, proposalFormView.proposalId!, proposalFormView);
    }

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  }
}
