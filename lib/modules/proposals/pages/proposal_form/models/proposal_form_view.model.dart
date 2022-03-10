import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/models/manifesto_option_view.model.dart';

class ProposalFormView {
  String? proposalId;
  String title;
  String content;
  ManifestoOptionType optionType;
  bool change = false;
  List<ManifestoOptionView> manifestoOptions;
  final ProposalFormType type;

  bool get isNew => proposalId == null;

  ProposalFormView(
      {required this.title,
      required this.content,
      required this.optionType,
      required this.manifestoOptions,
      required this.type,
      this.proposalId,
      this.change = false});

  factory ProposalFormView.createCopy(ProposalFormView p) => ProposalFormView(
      title: p.title,
      content: p.content,
      optionType: p.optionType,
      manifestoOptions: p.manifestoOptions,
      proposalId: p.proposalId,
      type: p.type,
      change: p.change);

  ProposalFormView.empty(
      {this.title = '',
      this.content = '',
      this.optionType = ManifestoOptionType.inFavorOrOpposing,
      this.manifestoOptions = const [],
      this.type = ProposalFormType.newProposal}) {
    manifestoOptions = [];
  }
}
