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

import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoCommentVoteRepository extends AppRepository implements Table {
  final String tblManifestoCommentVote = 'manifesto_comment_vote';
  final String colId = 'manifestoCommentVoteId';
  final String colManifestoCommentId = 'manifestoCommentId';
  final String colUserId = 'userId';
  final String colUpvote = 'upvote';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoCommentVote('
      '$colId TEXT PRIMARY KEY, '
      '$colManifestoCommentId TEXT, '
      '$colUserId TEXT, '
      '$colUpvote BOOLEAN,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';
}
