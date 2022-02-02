import 'package:bloc/bloc.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';
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
