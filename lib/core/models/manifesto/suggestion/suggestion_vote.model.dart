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

import 'package:demos_app/utils/parsers/parse_object_to_boolean.dart';

class SuggestionVote {
  final String suggestionVoteId;
  final String userHash;
  final bool isInFavor;
  final String createdAt;
  final String updatedAt;

  SuggestionVote(
    this.suggestionVoteId,
    this.userHash,
    this.isInFavor,
    this.createdAt,
    this.updatedAt,
  );

  factory SuggestionVote.fromObject(dynamic o) => SuggestionVote(
        o['suggestionVoteId'],
        o['userHash'],
        parseObjectToBoolean(o['isInFavor']),
        o['createdAt'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'suggestionVoteId': suggestionVoteId,
        'userHash': userHash,
        'isInFavor': isInFavor,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
