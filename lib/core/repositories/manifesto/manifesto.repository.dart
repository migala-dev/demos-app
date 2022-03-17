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
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';

class ManifestoRepository extends AppRepository implements Table {
  static final ManifestoRepository _manifestoRepository =
      ManifestoRepository._internal();

  factory ManifestoRepository() => _manifestoRepository;
  ManifestoRepository._internal();

  final String tblManifesto = 'manifesto';
  final String colId = 'manifestoId';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colOptionType = 'optionType';
  final String colSpaceId = 'spaceId';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifesto('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT, '
      '$colContent TEXT,'
      '$colOptionType INTEGER,'
      '$colSpaceId TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(Manifesto manifesto) async {
    Database? db = await this.db;
    Manifesto? manifestoSaved = await findById(manifesto.manifestoId);
    if (manifestoSaved == null) {
      await db!.insert(tblManifesto, manifesto.toMap());
      return manifesto.manifestoId;
    }
    return update(manifesto).toString();
  }

  Future<String> insert(Manifesto manifesto) async {
    Database? db = await this.db;
    Manifesto? manifestoSaved = await findById(manifesto.manifestoId);
    if (manifestoSaved == null) {
      await db!.insert(tblManifesto, manifesto.toMap());
      return manifesto.manifestoId;
    }
    return manifestoSaved.manifestoId;
  }

  Future<Manifesto?> findById(String manifestoId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tblManifesto WHERE $colId = '$manifestoId'");
    return result.isNotEmpty ? Manifesto.fromObject(result[0]) : null;
  }

  Future<int> update(Manifesto manifesto) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifesto '
        "SET $colTitle = '${secureSQLString(manifesto.title)}'"
        ", $colContent = '${secureSQLString(manifesto.content)}'"
        ', $colOptionType = ${manifesto.optionType.index}'
        ", $colUpdatedBy = '${manifesto.updatedBy}' "
        ", $colUpdatedAt = '${manifesto.updatedAt}' "
        "WHERE $colId = '${manifesto.manifestoId}'");
    return result;
  }
}
