enum ProposalStatus { draft, open, closed, cancelled }

ProposalStatus getProposalStatusFromInt(int status) {
  switch (status) {
    case 0:
      return ProposalStatus.draft;
    case 1:
      return ProposalStatus.open;
    case 2:
      return ProposalStatus.closed;
    default:
      return ProposalStatus.cancelled;
  }
}
