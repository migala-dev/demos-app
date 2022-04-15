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
import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalParticipationRepository extends AppRepository implements Table {
  final String tblProposalParticipations = 'proposalParticipations';
  final String colId = 'proposalParticipationId';
  final String colUserId = 'userId';
  final String colProposalId = 'proposalId';
  final String colMemberId = 'memberId';
  final String colSpaceId = 'spaceId';
  final String colParticipated = 'participated';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblProposalParticipations('
      '$colId TEXT PRIMARY KEY, '
      '$colUserId TEXT, '
      '$colProposalId TEXT, '
      '$colMemberId TEXT, '
      '$colSpaceId TEXT, '
      '$colParticipated BOOLEAN)';

  Future<String> insert(ProposalParticipation proposalParticipation) async {
    Database? db = await this.db;
    ProposalParticipation? proposalParticipationSaved =
        await findById(proposalParticipation.proposalParticipationId);
    if (proposalParticipationSaved == null) {
      await db!
          .insert(tblProposalParticipations, proposalParticipation.toMap());
      return proposalParticipation.proposalParticipationId;
    }
    return proposalParticipation.proposalParticipationId;
  }

  Future<String> insertOrUpdate(
      ProposalParticipation proposalParticipation) async {
    Database? db = await this.db;
    ProposalParticipation? proposalParticipationSaved =
        await findById(proposalParticipation.proposalParticipationId);
    if (proposalParticipationSaved == null) {
      await db!
          .insert(tblProposalParticipations, proposalParticipation.toMap());
      return proposalParticipation.proposalParticipationId;
    }
    return update(proposalParticipation).toString();
  }

  Future<ProposalParticipation?> findById(
      String proposalParticipationId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblProposalParticipations WHERE $colId = '$proposalParticipationId'");
    return result.isNotEmpty
        ? ProposalParticipation.fromObject(result[0])
        : null;
  }

  Future<ProposalParticipation?> findByMemberIdAndProposalId(
      String memberId, String proposalId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblProposalParticipations WHERE $colMemberId = '$memberId' AND $colProposalId = '$proposalId'");
    return result.isNotEmpty
        ? ProposalParticipation.fromObject(result[0])
        : null;
  }

  Future<ProposalParticipation?> findByUserIdAndProposalId(
      String userId, String proposalId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblProposalParticipations WHERE $colUserId = '$userId' AND $colProposalId = '$proposalId'");
    return result.isNotEmpty
        ? ProposalParticipation.fromObject(result[0])
        : null;
  }

  Future<int> update(ProposalParticipation participation) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate("""
        UPDATE $tblProposalParticipations
        SET $colParticipated = ${participation.participated ? 1 : 0} 
        WHERE $colId = '${participation.proposalParticipationId}'
      """);

    return result;
  }

  Future<void> removeByProposalId(String proposalId) async {
    Database? db = await this.db;
    await db!.rawDelete("DELETE FROM $tblProposalParticipations where $colProposalId = '$proposalId'");
  }
}
