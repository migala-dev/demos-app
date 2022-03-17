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

class ManifestoCommentVote {
  final String manifestoCommentVoteId;
  final String userId;
  final bool upvote;
  final String createdAt;
  final String updatedAt;

  ManifestoCommentVote(
    this.manifestoCommentVoteId,
    this.userId,
    this.upvote,
    this.createdAt,
    this.updatedAt,
  );

  factory ManifestoCommentVote.fromObject(dynamic o) => ManifestoCommentVote(
        o['manifestoCommentVoteId'],
        o['userId'],
        o['upvote'] == 1 ? true : false,
        o['createdAt'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoCommentVoteId': manifestoCommentVoteId,
        'userId': userId,
        'upvote': upvote ? 1 : 0,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
