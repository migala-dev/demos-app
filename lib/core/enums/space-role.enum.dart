enum SpaceRole { WORKER, ADMIN, REPRESENTATIVE }

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
