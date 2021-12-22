import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
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

    on<UpdateSpaceMember>((event, emit) async {
      final currentState = state;
      emit(SpaceMembersLoadInProgress());

      final member =
          await MemberViewService().getMemberViewByMemberId(event.memberId);

      if (member != null && currentState is SpaceMembersWithData) {
        emit(currentState.copyWithMemberUpdate(member));
      } else {
        emit(currentState);
      }
    });
  }
}
