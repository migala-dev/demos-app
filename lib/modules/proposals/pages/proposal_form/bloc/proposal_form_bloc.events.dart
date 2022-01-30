import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/modals/proposal_form_view.model.dart';
import 'package:equatable/equatable.dart';

abstract class ProposalFormBlocEvent extends Equatable {
  const ProposalFormBlocEvent();

  @override
  List<Object?> get props => [];
}

class ProposalFormSetProposalFormView extends ProposalFormBlocEvent {
  final ProposalFormView proposalFormView;

  const ProposalFormSetProposalFormView(this.proposalFormView);
}

class ProposalFormOnTitleChange extends ProposalFormBlocEvent {
  final String title;

  const ProposalFormOnTitleChange(this.title);
}

class ProposalFormOnContentChange extends ProposalFormBlocEvent {
  final String content;

  const ProposalFormOnContentChange(this.content);
}

class ProposalFormOnOptionTypeChange extends ProposalFormBlocEvent {
  final ManifestoOptionType optionType;

  const ProposalFormOnOptionTypeChange(this.optionType);
}

