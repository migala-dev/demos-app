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

import 'dart:io';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment.repository.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment_vote.repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/cache.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_references.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_vote.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';

class AppDatabase {
  static final List<Table> tables = [
    ProposalParticipationRepository(),
    ProposalVoteRepository(),
    ProposalRepository(),
    ManifestoOptionRepository(),
    ManifestoReferencesRepository(),
    ManifestoRepository(),
    CacheRepository(),
    MembersRepository(),
    SpacesRepository(),
    UsersRepository(),
    ManifestoCommentRepository(),
    ManifestoCommentVoteRepository()
  ];

  static Database? _db;
  static Future<Database?> get db async => _db ??= await initializaDb();

  static Future<Database> initializaDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/demos.db';
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  static void _createDb(Database db, int newVersion) async {
    for (final table in tables) {
      await db.execute(table.getCreateTableQuery());
    }
  }
}
