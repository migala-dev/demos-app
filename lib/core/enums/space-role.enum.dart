enum SpaceRole { WORKER, ADMIN, REPRESENTATIVE }

SpaceRole getSpaceRoleFromString(String role) {
  switch (role) {
    case "ADMIN":
      return SpaceRole.ADMIN;
    case "REPRESENTATIVE":
      return SpaceRole.REPRESENTATIVE;
    case "WORKER":
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
    default:
      return "WORKER";
  }
}
