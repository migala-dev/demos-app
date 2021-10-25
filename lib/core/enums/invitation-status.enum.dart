enum InvitationStatus {
  SENDED,
  RECEIVED,
  ACCEPTED,
  CANCELED,
  REJECTED
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
      return InvitationStatus.CANCELED;
    case 4:
    default:
      return InvitationStatus.REJECTED;
  }
}
