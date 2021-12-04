enum MemberType { administrator, invited, worker, all, representative }

String getMemberTypeName(MemberType memberType) {
  switch (memberType) {
    case MemberType.administrator:
      return 'ADMIN';
    case MemberType.invited:
      return 'INVITADO';
    case MemberType.representative:
      return 'REPRESENTANTE';
    default:
      return 'TRABAJADOR';
  }
}
