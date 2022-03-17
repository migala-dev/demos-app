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

class ManifestoCommentRepository extends AppRepository implements Table {
  final String tblManifestoComment = 'manifesto_comment';
  final String colId = 'manifestoCommentId';
  final String colContent = 'content';
  final String colManifestoCommentParentId = 'manifestoCommentParentId';
  final String colDeleted = 'deleted';
  final String colCreatedAt = 'createdAt';
  final String colCreatedByMember = 'createdByMember';
  final String colUpdatedBy = 'updatedBy';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoComment('
      '$colId TEXT PRIMARY KEY, '
      '$colContent TEXT,'
      '$colManifestoCommentParentId TEXT,'
      '$colDeleted BOOLEAN,'
      '$colCreatedAt TEXT,'
      '$colCreatedByMember TEXT,'
      '$colUpdatedBy TEXT)';
}
