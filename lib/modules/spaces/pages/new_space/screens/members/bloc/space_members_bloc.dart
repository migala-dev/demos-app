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

import 'package:bloc/bloc.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:equatable/equatable.dart';

part 'space_members_event.dart';
part 'space_members_state.dart';

class SpaceMembersBloc extends Bloc<SpaceMembersEvent, SpaceMembersState> {
  static final SpaceMembersBloc _bloc = SpaceMembersBloc._internal();

  factory SpaceMembersBloc() => _bloc;

  SpaceMembersBloc._internal() : super(SpaceMembersLoadInProgress()) {
    on<LoadSpaceMembers>((event, emit) async {
      emit(SpaceMembersLoadInProgress());
      final memberViews = await MemberViewService().getMemberViews();
      final MemberView? currentMember = CurrentMemberBloc().state;
      if (currentMember != null && currentMember.role == SpaceRole.admin) {
        final memberPhoneNumbers =
            await MemberService().getMemberPhoneNumbers(currentMember.spaceId!);
        for (final memberPhoneNumber in memberPhoneNumbers) {
          if (memberViews
              .any((m) => memberPhoneNumber.memberId == m.memberId)) {
            final MemberView member = memberViews
                .firstWhere((m) => memberPhoneNumber.memberId == m.memberId);
            member.phoneNumber = memberPhoneNumber.phoneNumber;
          }
        }
      }
      emit(SpaceMembersWithData(memberViews));
    });

    on<SpaceMemberUpdated>((event, emit) async {
      final currentState = state;
      emit(SpaceMembersLoadInProgress());
      final member =
          await MemberViewService().getMemberViewByMemberId(event.memberId);

      if (currentState is SpaceMembersWithData) {
        if (member == null) {
          emit(currentState.copyWithMemberDeleted(event.memberId));
          return;
        }

        if (member.invitationStatus! == InvitationStatus.accepted ||
            member.invitationStatus! == InvitationStatus.received) {
          emit(currentState.copyWithMemberUpdate(member));
        } else if (member.invitationStatus! == InvitationStatus.sended) {
          emit(currentState.copyWithNewInvitation(member));
        } else if (member.invitationStatus! == InvitationStatus.rejected ||
            member.invitationStatus! == InvitationStatus.canceled) {
          emit(currentState.copyWithMemberDeleted(member.memberId!));
        } else {
          emit(currentState);
        }
      } else {
        emit(currentState);
      }
    });

    on<SpaceMemberDeleted>((event, emit) async {
      if (state is SpaceMembersWithData) {
        emit((state as SpaceMembersWithData)
            .copyWithMemberDeleted(event.userId));
      }
    });
  }
}
