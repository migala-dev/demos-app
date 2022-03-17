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

import 'package:demos_app/utils/secure_sql_string.util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoOptionRepository extends AppRepository implements Table {
  final String tblManifestoOptions = 'manifesto_options';
  final String colId = 'manifestoOptionId';
  final String colTitle = 'title';
  final String colManifestoId = 'manifestoId';
  final String colDeleted = 'deleted';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoOptions('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT,'
      '$colManifestoId TEXT,'
      '$colDeleted BOOLEAN,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    ManifestoOption? manifestoOptionSaved =
        await findById(manifestoOption.manifestoOptionId);
    if (manifestoOptionSaved == null) {
      await db!.insert(tblManifestoOptions, manifestoOption.toMap());
      return manifestoOption.manifestoOptionId;
    }
    return update(manifestoOption).toString();
  }

  Future<String> insert(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    ManifestoOption? manifestoOptionSaved =
        await findById(manifestoOption.manifestoOptionId);
    if (manifestoOptionSaved == null) {
      await db!.insert(tblManifestoOptions, manifestoOption.toMap());
      return manifestoOption.manifestoOptionId;
    }
    return manifestoOptionSaved.manifestoOptionId;
  }

  Future<ManifestoOption?> findById(String manifestoOptionId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblManifestoOptions WHERE $colId = '$manifestoOptionId'");
    return result.isNotEmpty ? ManifestoOption.fromObject(result[0]) : null;
  }

  Future<List<ManifestoOption>> findByManifestoId(String manifestoId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblManifestoOptions WHERE $colManifestoId = '$manifestoId'");
    return result.map((row) => ManifestoOption.fromObject(row)).toList();
  }

  Future<int> update(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifestoOptions '
        "SET $colTitle = '${secureSQLString(manifestoOption.title)}'"
        ', $colDeleted = ${manifestoOption.deleted ? 1 : 0} '
        ", $colUpdatedBy = '${manifestoOption.updatedBy}' "
        ", $colUpdatedAt = '${manifestoOption.updatedAt}' "
        "WHERE $colId = '${manifestoOption.manifestoOptionId}'");
    return result;
  }

  Future<void> removeAllMissingOptions(
      List<ManifestoOption> currentManifestoOptions, String manifestoId) async {
    List<ManifestoOption> manifestoOptions =
        await findByManifestoId(manifestoId);

    for (ManifestoOption option in manifestoOptions) {
      if (currentManifestoOptions
          .every((o) => o.manifestoOptionId != option.manifestoOptionId)) {
        await delete(option.manifestoOptionId);
      }
    }
  }

  Future<int> delete(String manifestoOptionId) async {
    int result;
    Database? db = await this.db;
    result = await db!.rawDelete(
        "DELETE FROM $tblManifestoOptions where $colId = '$manifestoOptionId'");
    return result;
  }
}
