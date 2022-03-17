/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
