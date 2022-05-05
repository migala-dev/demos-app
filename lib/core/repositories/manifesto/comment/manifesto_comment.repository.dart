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
import 'package:demos_app/core/models/manifesto/comment/manifesto_comment.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ManifestoCommentRepository extends AppRepository implements Table {
  final String tblManifestoComment = 'manifesto_comment';
  final String colId = 'manifestoCommentId';
  final String colContent = 'content';
  final String colManifestoCommentParentId = 'manifestoCommentParentId';
  final String colDeleted = 'deleted';
  final String colCreatedAt = 'createdAt';
  final String colCreatedByMember = 'createdByMember';
  final String colUpdatedAt = 'updatedAt';
  final String colManifestoId = 'manifestoId';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoComment('
      '$colId TEXT PRIMARY KEY, '
      '$colContent TEXT,'
      '$colManifestoCommentParentId TEXT,'
      '$colDeleted BOOLEAN,'
      '$colCreatedAt TEXT,'
      '$colCreatedByMember TEXT,'
      '$colUpdatedAt TEXT,'
      '$colManifestoId TEXT)';

  Future<ManifestoComment?> findById(String manifestoCommentId) async {
    final Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblManifestoComment WHERE $colId = '$manifestoCommentId'");
    return result.isNotEmpty ? ManifestoComment.fromObject(result[0]) : null;
  }

  Future<int> update(ManifestoComment comment) async {
    final Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifestoComment '
        "SET $colContent = '${comment.content}'"
        ", $colManifestoCommentParentId = '${comment.manifestoCommentParentId}'"
        ", $colDeleted = '${comment.deleted ? 1 : 0}'"
        ", $colCreatedAt = '${comment.createdAt}'"
        ", $colCreatedByMember = '${comment.createdByMember}'"
        ", $colUpdatedAt = '${comment.updatedAt}' "
        ", $colManifestoId = '${comment.manifestoCommentId}' "
        "WHERE $colId = '${comment.manifestoCommentId}'");
    return result;
  }

  Future<String> insertOrUpdate(ManifestoComment comment) async {
    final Database? db = await this.db;
    final ManifestoComment? proposalSaved =
        await findById(comment.manifestoCommentId);
    if (proposalSaved == null) {
      await db!.insert(tblManifestoComment, comment.toMap());
      return comment.manifestoCommentId;
    }
    return update(comment).toString();
  }
}
