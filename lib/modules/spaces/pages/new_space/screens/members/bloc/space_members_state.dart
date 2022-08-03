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

part of 'space_members_bloc.dart';

abstract class SpaceMembersState extends Equatable {
  const SpaceMembersState();

  @override
  List<Object> get props => [];
}

class SpaceMembersLoadInProgress extends SpaceMembersState {}

class SpaceMembersWithData extends SpaceMembersState {
  final List<MemberView> memberViews;

  const SpaceMembersWithData(this.memberViews);

  @override
  List<Object> get props => [memberViews];

  SpaceMembersWithData copyWithMemberUpdate(MemberView memberUpdated) {
    int memberIndex = memberViews
        .indexWhere((member) => member.memberId == memberUpdated.memberId);
    if (memberIndex != -1) {
      final oldMember = memberViews[memberIndex];
      memberUpdated.phoneNumber = oldMember.phoneNumber;
      memberViews.removeAt(memberIndex);
      memberViews.insert(memberIndex, memberUpdated);
    }

    return SpaceMembersWithData([...memberViews]);
  }

  SpaceMembersWithData copyWithMemberDeleted(String memberId) {
    memberViews.removeWhere((member) => member.memberId == memberId);

    return SpaceMembersWithData([...memberViews]);
  }

  SpaceMembersWithData copyWithNewInvitation(MemberView newMember) {
    memberViews.add(newMember);

    return SpaceMembersWithData([...memberViews]);
  }

  bool hasRepresentative() =>
      memberViews.any((member) => member.role == SpaceRole.representative);
}
