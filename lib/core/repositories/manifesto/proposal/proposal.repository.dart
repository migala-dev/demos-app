import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ProposalRepository extends BaseRepository {
  @override
  String get fileName => 'proposals';
  final String tbProposals = 'proposals';
  final String colId = 'proposalId';
  final String colManifestoId = 'manifestoId';
  final String colStatus = 'status';
  final String colProgressStatus = 'progressStatus';
  final String colExpiratedAt = 'expiratedAt';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colId TEXT PRIMARY KEY, '
        '$colManifestoId TEXT,'
        '$colStatus INTEGER,'
        '$colProgressStatus INTEGER,'
        '$colExpiratedAt TEXT)');
  }
}
