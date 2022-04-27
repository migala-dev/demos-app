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
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalVoteRepository extends AppRepository implements Table {
  final String tbProposalVotes = 'proposalVotes';
  final String colId = 'proposalVoteId';
  final String colProposalId = 'proposalId';
  final String colUserHash = 'userHash';
  final String colManifestoOptionId = 'manifestoOptionId';
  final String colInFavor = 'inFavor';
  final String colNullVoteComment = 'nullVoteComment';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbProposalVotes('
      '$colId TEXT PRIMARY KEY, '
      '$colProposalId TEXT,'
      '$colUserHash TEXT,'
      '$colManifestoOptionId TEXT,'
      '$colInFavor BOOLEAN,'
      '$colNullVoteComment TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insert(ProposalVote vote) async {
    final Database? db = await this.db;
    final ProposalVote? voteSaved = await findById(vote.proposalVoteId);
    if (voteSaved == null) {
      await db!.insert(tbProposalVotes, vote.toMap());
      return vote.proposalVoteId;
    }
    return vote.proposalVoteId;
  }

  Future<ProposalVote?> findById(String voteId) async {
    final Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tbProposalVotes WHERE $colId = '$voteId'");
    return result.isNotEmpty ? ProposalVote.fromObject(result[0]) : null;
  }

  Future<List<ProposalVote>> getVotesByProposalId(String proposalId) async {
    final Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tbProposalVotes WHERE $colProposalId = '$proposalId'");

    return result.map((row) => ProposalVote.fromObject(row)).toList();
  }
}
