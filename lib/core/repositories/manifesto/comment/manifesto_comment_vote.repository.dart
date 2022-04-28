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
import 'package:demos_app/core/models/manifesto/comment/manifesto_comment_vote.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<ManifestoCommentVote?> findById(String manifestoCommentVoteId) async {
    final Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblManifestoCommentVote WHERE $colId = '$manifestoCommentVoteId'");
    return result.isNotEmpty
        ? ManifestoCommentVote.fromObject(result[0])
        : null;
  }

  Future<ManifestoCommentVote?> findByManifestoCommentIdAndUserId(
      String manifestoCommentId, String userId) async {
    final Database? db = await this.db;
    final result = await db!.rawQuery('SELECT * FROM $tblManifestoCommentVote '
        "WHERE $colManifestoCommentId = '$manifestoCommentId' AND $colUserId = '$userId'");
    return result.isNotEmpty
        ? ManifestoCommentVote.fromObject(result[0])
        : null;
  }

  Future<int> update(ManifestoCommentVote commentVote) async {
    final Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifestoCommentVote '
        "SET $colManifestoCommentId = '${commentVote.manifestoCommentId}'"
        ", $colUserId = '${commentVote.userId}'"
        ", $colUpvote = '${commentVote.upvote ? 1 : 0}'"
        ", $colCreatedAt = '${commentVote.createdAt}'"
        ", $colUpdatedAt = '${commentVote.updatedAt}' "
        "WHERE $colId = '${commentVote.manifestoCommentVoteId}'");
    return result;
  }

  Future<String> insertOrUpdate(ManifestoCommentVote commentVote) async {
    final Database? db = await this.db;
    final ManifestoCommentVote? proposalSaved =
        await findById(commentVote.manifestoCommentVoteId);
    if (proposalSaved == null) {
      await db!.insert(tblManifestoCommentVote, commentVote.toMap());
      return commentVote.manifestoCommentId;
    }
    return update(commentVote).toString();
  }

  Future<int> delete(String manifestoCommentVoteId) async {
    final Database? db = await this.db;
    final result = await db!.rawDelete('DELETE FROM $tblManifestoCommentVote '
        "WHERE $colId = '$manifestoCommentVoteId'");
    return result;
  }
}
