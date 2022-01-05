enum ProposalProgressStatus { pending, progress, finished, cancelled }

ProposalProgressStatus getProposalProgressStatusFromInt(int status) {
  switch (status) {
    case 0:
      return ProposalProgressStatus.pending;
    case 1:
      return ProposalProgressStatus.progress;
    case 2:
      return ProposalProgressStatus.finished;
    default:
      return ProposalProgressStatus.cancelled;
  }
}
