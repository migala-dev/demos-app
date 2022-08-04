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

class SpaceView {
  final String? spaceId;
  final String name;
  final String? pictureKey;
  final String? description;
  final int participationPercentage;
  final int approvalPercentage;
  final int membersCount;
  final String createdAt;
  final String proposalsLastUpdatedDate;
  final String manifestoLastUpdatedDate;

  DateTime get lastActivityDate {
    final List<DateTime> dates = [DateTime.parse(createdAt)];
    if (proposalsLastUpdatedDate.isNotEmpty) {
      dates.add(DateTime.parse(proposalsLastUpdatedDate));
    }
    if (manifestoLastUpdatedDate.isNotEmpty) {
      dates.add(DateTime.parse(manifestoLastUpdatedDate));
    } 
    dates.sort((a, b) => b.compareTo(a));
    return dates.first;
  } 

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      this.membersCount = 0,
      this.description,
      this.approvalPercentage = 51,
      this.participationPercentage = 51,
      this.createdAt = '',
      this.proposalsLastUpdatedDate = '',
      this.manifestoLastUpdatedDate = ''});

  factory SpaceView.fromObject(Map<String, dynamic> o) => SpaceView(
      spaceId: o['spaceId'],
      name: o['name'],
      pictureKey: o['pictureKey'],
      membersCount: o['membersCount'],
      description: o['description'],
      participationPercentage: o['participationPercentage'],
      approvalPercentage: o['approvalPercentage'],
      createdAt: o['createdAt'],
      proposalsLastUpdatedDate: o['proposalsLastUpdatedDate'] ?? '',
      manifestoLastUpdatedDate: o['manifestoLastUpdatedDate'] ?? '');

  SpaceView.empty(
      {this.spaceId,
      this.name = '',
      this.pictureKey = '',
      this.membersCount = 0,
      this.description = '',
      this.approvalPercentage = 51,
      this.participationPercentage = 51,
      this.createdAt = '',
      this.proposalsLastUpdatedDate = '',
      this.manifestoLastUpdatedDate = ''});

}
