enum InvitationStatus { sended, received, accepted, canceled, rejected, expired }

InvitationStatus getInvitationStatusFromInt(int status) {
  switch (status) {
    case 0:
      return InvitationStatus.sended;
    case 1:
      return InvitationStatus.received;
    case 2:
      return InvitationStatus.accepted;
    case 3:
      return InvitationStatus.canceled;
    case 4:
      return InvitationStatus.rejected;
    case 5:
    default:
      return InvitationStatus.expired;
  }
}
