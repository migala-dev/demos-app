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
