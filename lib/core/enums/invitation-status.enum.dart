enum InvitationStatus {
  SENDED,
  RECEIVED,
  ACCEPTED,
  CANCELED,
}

InvitationStatus getInvitationStatusFromInt(int status) {
  switch (status) {
    case 0:
      return InvitationStatus.SENDED;
    case 1:
      return InvitationStatus.RECEIVED;
    case 2:
      return InvitationStatus.ACCEPTED;
    case 3:
    default:
      return InvitationStatus.CANCELED;
  }
}
