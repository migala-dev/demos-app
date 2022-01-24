class NewProposalContentService {
  static final NewProposalContentService _newProposalContentService =
      NewProposalContentService._internal();

  factory NewProposalContentService() => _newProposalContentService;
  NewProposalContentService._internal();

  String? title;
  String? content;

  bool isEmpty() =>
      (title == null && content == null) ||
      (title!.isEmpty && content!.isEmpty);

  void emptyNewProposal() {
    title = null;
    content = null;
  }
}
