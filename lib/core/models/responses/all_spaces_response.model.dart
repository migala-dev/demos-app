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

class AllSpacesResponse {
  late List<Space> _spaces;
  late List<Member> _members;
  late List<User> _users;

  List<Space> get spaces => _spaces;
  List<Member> get members => _members;
  List<User> get users => _users;

  AllSpacesResponse.fromObject(dynamic o) {
    List<dynamic> spacesResponse = o['spaces'];
    _spaces = spacesResponse.map((s) => Space.fromObject(s)).toList();

    List<dynamic> membersResponse = o['members'];
    _members = membersResponse.map((s) => Member.fromObject(s)).toList();

    List<dynamic> usersResponse = o['users'];
    _users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}
