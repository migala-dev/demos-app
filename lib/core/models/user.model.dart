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

import 'package:demos_app/shared/services/date_formatter.service.dart';

class User {
  String? _userId;
  String? _name;
  late String _phoneNumber;
  String? _profilePictureKey;
  String? _createdAt;
  String? _updatedAt;

  User.withPhoneNumber(this._phoneNumber);

  String? get userId => _userId;
  String get name => _name ?? '';
  String get phoneNumber => _phoneNumber;
  String? get profilePictureKey => _profilePictureKey;
  String get createdAtFormatted =>
      DateFormatterService.parseToStandardDate(_createdAt ?? '');

  set name(String name) => _name = name;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['userId'] = _userId;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['profilePictureKey'] = _profilePictureKey;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  User.fromObject(dynamic o) {
    _userId = o['userId'];
    _name = o['name'];
    _phoneNumber = o['phoneNumber'];
    _profilePictureKey =
        o['profilePictureKey'] == 'null' ? null : o['profilePictureKey'];
    _createdAt = o['createdAt'];
    _updatedAt = o['updatedAt'];
  }

  User.fromUserObject(User user) {
    _userId = user.userId;
    _name = user.name;
    _phoneNumber = user.phoneNumber;
    _profilePictureKey = user.profilePictureKey;
  }
}
