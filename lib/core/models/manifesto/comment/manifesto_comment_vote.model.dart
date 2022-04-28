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

class ManifestoCommentVote {
  final String manifestoCommentVoteId;
  final String manifestoCommentId;
  final String userId;
  final bool upvote;
  final String createdAt;
  final String updatedAt;

  ManifestoCommentVote(
    this.manifestoCommentVoteId,
    this.manifestoCommentId,
    this.userId,
    this.upvote,
    this.createdAt,
    this.updatedAt,
  );

  factory ManifestoCommentVote.fromObject(dynamic o) => ManifestoCommentVote(
        o['manifestoCommentVoteId'],
        o['manifestoCommentId'],
        o['userId'],
        parseObjectToBoolean(o['upvote']),
        o['createdAt'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoCommentVoteId': manifestoCommentVoteId,
        'manifestoCommentId': manifestoCommentId,
        'userId': userId,
        'upvote': upvote ? 1 : 0,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
