import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';

class ProposalFormView {
  String? proposalId;
  String title;
  String content;
  ManifestoOptionType optionType;
  final bool isNew;
  bool change = false;

  ProposalFormView(
      {required this.title,
      required this.content,
      required this.optionType,
      required this.isNew,
      this.proposalId});

  ProposalFormView.empty(
      {this.title = '',
      this.content = '',
      this.optionType = ManifestoOptionType.inFavorOrOpposing,
      this.isNew = true});
}
