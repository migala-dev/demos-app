import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.event.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';
import 'package:demos_app/modules/spaces/repositories/member_view.repository.dart';
import 'package:demos_app/modules/spaces/repositories/space_view.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceView> {
  static final SpaceBloc _spaceBloc = SpaceBloc._internal();

  factory SpaceBloc() {
    return _spaceBloc;
  }

  SpaceBloc._internal() : super(SpaceView.empty()) {
    on<SetSpaceIdEvent>((event, emit) async {
      String spaceId = event.spaceId;
      await set(spaceId, emit);
    });
    on<SetSpaceViewEvent>((event, emit) async {
      SpaceView spaceView = event.spaceView;
      
      setCurrentMember(spaceView.spaceId!);

      emit(spaceView);
    });
    on<UpdateSpaceEvent>((event, emit) async {
      String spaceId = event.spaceId;

      if (state.spaceId == spaceId) {
        await set(spaceId, emit);
      }
    });
  }

  Future<void> set(String spaceId, Emitter<SpaceView?> emit) async {
    SpaceView space = await SpaceViewsRepository().findById(spaceId);

    setCurrentMember(spaceId);

    emit(space);
  }

  Future<void> setCurrentMember(String spaceId) async {
    User? user = CurrentUserBloc().state;
    MemberView? memberView = await MemberViewsRepository().findByUserIdAndSpaceId(user!.userId!, spaceId);
    if (memberView != null) {
      CurrentMemberBloc().add(SetCurrentMemberEvent(memberView));
    }
  }
}
