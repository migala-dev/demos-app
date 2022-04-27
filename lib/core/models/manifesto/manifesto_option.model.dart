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

class ManifestoOption {
  final String manifestoOptionId;
  final String title;
  final String manifestoId;
  final bool deleted;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  ManifestoOption(
    this.manifestoOptionId,
    this.title,
    this.manifestoId,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  );

  factory ManifestoOption.fromObject(dynamic o) => ManifestoOption(
        o['manifestoOptionId'],
        o['title'],
        o['manifestoId'],
        o['deleted'] == 1,
        o['createdBy'],
        o['createdAt'],
        o['updatedBy'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'manifestoOptionId': manifestoOptionId,
        'title': title,
        'manifestoId': manifestoId,
        'deleted': deleted ? 1 : 0,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'updatedBy': updatedBy,
        'updatedAt': updatedAt,
      };
}
