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
  final String userId;
  final String name;
  String? phoneNumber;
  final String? profilePictureKey;
  final String createdAt;
  final String updatedAt;

  User(
    this.userId,
    this.name,
    this.profilePictureKey,
    this.createdAt,
    this.updatedAt
  );

  String get createdAtFormatted =>
      DateFormatterService.parseToStandardDate(createdAt);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['userId'] = userId;
    map['name'] = name;
    map['profilePictureKey'] = profilePictureKey;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  factory User.fromObject(dynamic o) =>  User(
    o['userId'],
    o['name'],
     o['profilePictureKey'] == 'null' ? null : o['profilePictureKey'],
     o['createdAt'],
     o['updatedAt']
  );
}
