import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/models/manifesto_option_view.model.dart';

class ProposalFormView {
  String? proposalId;
  String title;
  String content;
  ManifestoOptionType optionType;
  final bool isNew;
  bool change = false;
  List<ManifestoOptionView> manifestoOptions;

  ProposalFormView(
      {required this.title,
      required this.content,
      required this.optionType,
      required this.isNew,
      required this.manifestoOptions,
      this.proposalId,
      this.change = false});

  factory ProposalFormView.createCopy(ProposalFormView p) => ProposalFormView(
      title: p.title,
      content: p.content,
      optionType: p.optionType,
      isNew: p.isNew,
      manifestoOptions: p.manifestoOptions,
      proposalId: p.proposalId,
      change: p.change);

  ProposalFormView.empty(
      {this.title = '',
      this.content = '',
      this.optionType = ManifestoOptionType.inFavorOrOpposing,
      this.isNew = true,
      this.manifestoOptions = const []}) {
    manifestoOptions = [];
  }
}
