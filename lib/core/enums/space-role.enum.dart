enum SpaceRole { WORKER, ADMIN, REPRESENTATIVE, INVITED }

SpaceRole getSpaceRoleFromString(String role) {
  switch (role) {
    case "ADMIN":
      return SpaceRole.ADMIN;
    case "REPRESENTATIVE":
      return SpaceRole.REPRESENTATIVE;
    default:
      return SpaceRole.WORKER;
  }
}

String getSpaceRoleString(SpaceRole? role) {
  switch (role) {
    case SpaceRole.ADMIN:
      return "ADMIN";
    case SpaceRole.REPRESENTATIVE:
      return "REPRESENTATIVE";
    case SpaceRole.WORKER:
      return "WORKER";
    default:
      return 'INVITADO';
  }
}
