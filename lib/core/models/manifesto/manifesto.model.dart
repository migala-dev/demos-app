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

import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';

class Manifesto {
  final String manifestoId;
  final String? title;
  final String? content;
  final ManifestoOptionType optionType;
  final String spaceId;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  Manifesto(
      this.manifestoId,
      this.title,
      this.content,
      this.optionType,
      this.spaceId,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt);

  factory Manifesto.fromObject(dynamic o) => Manifesto(
        o['manifestoId'],
        o['title'],
        o['content'],
        ManifestoOptionType.values[o['optionType']],
        o['spaceId'],
        o['createdBy'],
        o['createdAt'],
        o['updatedBy'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoId': manifestoId,
        'title': title,
        'content': content,
        'optionType': optionType.index,
        'spaceId': spaceId,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'updatedBy': updatedBy,
        'updatedAt': updatedAt,
      };
}
