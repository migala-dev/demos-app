enum InvitationStatus {
  SENDED,
  RECEIVED,
  ACCEPTED,
  CANCELED,
}

InvitationStatus getInvitationStatusFromInt(int status) {
  switch (status) {
    case 1:
      return InvitationStatus.RECEIVED;
    case 2:
      return InvitationStatus.ACCEPTED;
    case 3:
      return InvitationStatus.CANCELED;
    case 0:
    default:
      return InvitationStatus.SENDED;
  }
}
