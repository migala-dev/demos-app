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
