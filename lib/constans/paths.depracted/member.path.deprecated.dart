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

import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class MemberPathDeprecated {
  String getMembersPath() {
    Enviroment enviroment = getDeprecatedEnviroment();
    return '${enviroment.spaceServiceUrl}/members';
  }

  String getMembersSpacePath(String spaceId) {
    return '${getMembersPath()}/$spaceId';
  }

  String getMembersPhoneNumbersPath(String spaceId) {
    return '${getMembersSpacePath(spaceId)}/members/phones';
  }

  String getInvitationPath(String spaceId) {
    return '${getMembersSpacePath(spaceId)}/invitation';
  }

  String getAcceptInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/accept';
  }

  String getRejectInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/reject';
  }

  String getMemberPath(String spaceId, String memberId) {
    return '${getMembersSpacePath(spaceId)}/$memberId';
  }

  String getMemberInvitationPath(String spaceId, String memberId) {
    return '${getInvitationPath(spaceId)}/$memberId';
  }
}
