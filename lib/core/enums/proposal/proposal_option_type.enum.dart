enum ProposalOptionType { inFavourOrOpposing, multipleOptions }

ProposalOptionType getProposalOptionTypeFromInt(int option) {
  switch (option) {
    case 0:
      return ProposalOptionType.inFavourOrOpposing;
    default:
      return ProposalOptionType.multipleOptions;
  }
}
