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

import '../space.model.dart';
import '../user.model.dart';
import '../member.model.dart';

class AcceptInvitationResponse {
  late Space _space;
  late List<Member> _members;
  late List<User> _users;

  Space get space => _space;
  List<Member> get members => _members;
  List<User> get users => _users;

  AcceptInvitationResponse.fromObject(dynamic o) {
    _space = Space.fromObject(o['space']);

    List<dynamic> membersResponse = o['members'];
    _members = membersResponse.map((m) => Member.fromObject(m)).toList();

    List<dynamic> usersResponse = o['users'];
    _users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}
