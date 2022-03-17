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

class Space {
  String? _spaceId;
  String? _pictureKey;
  String? _ownerId;
  String? _createdAt;
  String? _updatedAt;
  String? name;
  String? description;
  int participationPercentage = 51;
  int approvalPercentage = 51;

  String? get spaceId => _spaceId;
  String? get pictureKey => _pictureKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Space();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['spaceId'] = _spaceId;
    map['name'] = name;
    map['description'] = description;
    map['pictureKey'] = _pictureKey;
    map['approvalPercentage'] = approvalPercentage;
    map['participationPercentage'] = participationPercentage;
    map['ownerId'] = _ownerId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  Space.fromObject(dynamic o) {
    _spaceId = o['spaceId'];
    name = o['name'];
    description = o['description'];
    _pictureKey = o['pictureKey'];
    approvalPercentage = o['approvalPercentage'];
    participationPercentage = o['participationPercentage'];
    _ownerId = o['ownerId'];
    _createdAt = o['createdAt'];
    _updatedAt = o['updatedAt'];
  }
}
