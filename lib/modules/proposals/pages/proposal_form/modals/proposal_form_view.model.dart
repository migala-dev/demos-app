import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';

class ProposalFormView {
  String title;
  String content;
  ManifestoOptionType optionType;

  ProposalFormView(
      {required this.title, required this.content, required this.optionType});

  ProposalFormView.empty({
    this.title = '',
    this.content = '',
    this.optionType = ManifestoOptionType.inFavorOrOpposing,
  });
}
