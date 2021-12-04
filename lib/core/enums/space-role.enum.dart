enum SpaceRole { worker, admin, representative }

SpaceRole getSpaceRoleFromString(String role) {
  switch (role) {
    case 'ADMIN':
      return SpaceRole.admin;
    case 'REPRESENTATIVE':
      return SpaceRole.representative;
    case 'WORKER':
    default:
      return SpaceRole.worker;
  }
}

String getSpaceRoleString(SpaceRole? role) {
  switch (role) {
    case SpaceRole.admin:
      return 'ADMIN';
    case SpaceRole.representative:
      return 'REPRESENTATIVE';
    case SpaceRole.worker:
    default:
      return 'WORKER';
  }
}

String getSpaceRoleName(SpaceRole? role) {
  switch (role) {
    case SpaceRole.admin:
      return 'Administrador';
    case SpaceRole.representative:
      return 'Representante';
    case SpaceRole.worker:
    default:
      return 'Trabajador';
  }
}
