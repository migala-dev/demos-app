enum ProposalOptionType { aFavorEnContra, multipleOptions }

ProposalOptionType getProposalOptionTypeFromInt(int proposal) {
  switch (proposal) {
    case 0:
      return ProposalOptionType.aFavorEnContra;
    default:
      return ProposalOptionType.multipleOptions;
  }
}
