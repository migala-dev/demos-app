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

class SuggestionParticipaation {
  final String suggestionParticipationId;
  final String suggestionId;
  final String userId;
  final String memberId;

  SuggestionParticipaation(
    this.suggestionParticipationId,
    this.suggestionId,
    this.userId,
    this.memberId,
  );

  factory SuggestionParticipaation.fromObject(dynamic o) =>
      SuggestionParticipaation(
        o['suggestionParticipationId'],
        o['suggestionId'],
        o['userId'],
        o['memberId'],
      );

  Map<String, dynamic> toMap() => {
        'suggestionParticipationId': suggestionParticipationId,
        'suggestionId': suggestionId,
        'userId': userId,
        'memberId': memberId,
      };
}
