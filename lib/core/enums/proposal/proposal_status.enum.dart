enum ProposalStatus { open, closed, cancelled }

ProposalStatus getProposalStatusFromInt(int status) {
  switch (status) {
    case 0:
      return ProposalStatus.open;
    case 1:
      return ProposalStatus.closed;
    default:
      return ProposalStatus.cancelled;
  }
}
