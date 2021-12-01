enum MemberType { ADMINISTRATOR, INVITED, WORKER, ALL, REPRESENTATIVE }

String getMemberTypeName(MemberType memberType) {
  switch (memberType) {
    case MemberType.ADMINISTRATOR:
      return "ADMIN";
    case MemberType.INVITED:
      return "INVITADO";
    case MemberType.REPRESENTATIVE:
      return 'REPRESENTANTE';
    default:
      return "TRABAJADOR";
  }
}
