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
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalRepository extends AppRepository implements Table {
  static final ProposalRepository _proposalRepository =
      ProposalRepository.internal();
  ProposalRepository.internal();
  factory ProposalRepository() => _proposalRepository;

  final String tblProposals = 'proposals';
  final String colId = 'proposalId';
  final String colManifestoId = 'manifestoId';
  final String colStatus = 'status';
  final String colProgressStatus = 'progressStatus';
  final String colExpiredAt = 'expiredAt';
  final String colSpaceId = 'spaceId';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblProposals('
      '$colId TEXT PRIMARY KEY, '
      '$colManifestoId TEXT,'
      '$colStatus INTEGER,'
      '$colProgressStatus INTEGER,'
      '$colExpiredAt TEXT,'
      '$colSpaceId TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(Proposal proposal) async {
    Database? db = await this.db;
    Proposal? proposalSaved = await findById(proposal.proposalId);
    if (proposalSaved == null) {
      await db!.insert(tblProposals, proposal.toMap());
      return proposal.proposalId;
    }
    return update(proposal).toString();
  }

  Future<String> insert(Proposal proposal) async {
    Database? db = await this.db;
    Proposal? proposalSaved = await findById(proposal.proposalId);
    if (proposalSaved == null) {
      await db!.insert(tblProposals, proposal.toMap());
      return proposal.proposalId;
    }
    return proposalSaved.proposalId;
  }

  Future<Proposal?> findById(String proposalId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tblProposals WHERE $colId = '$proposalId'");
    return result.isNotEmpty ? Proposal.fromObject(result[0]) : null;
  }

  Future<int> update(Proposal proposal) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblProposals '
        'SET $colStatus = ${proposal.status.index}'
        ', $colProgressStatus = ${proposal.progressStatus.index}'
        ", $colExpiredAt = '${proposal.expiredAt}'"
        ", $colUpdatedBy = '${proposal.updatedBy}' "
        ", $colUpdatedAt = '${proposal.updatedAt}' "
        "WHERE $colId = '${proposal.proposalId}'");
    return result;
  }
}
