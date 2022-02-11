import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.event.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';
import 'package:demos_app/modules/spaces/repositories/member_view.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceBloc extends Bloc<SpaceEvent, Space?> {
  static final SpaceBloc _spaceBloc = SpaceBloc._internal();

  factory SpaceBloc() {
    return _spaceBloc;
  }

  SpaceBloc._internal() : super(null) {
    on<SetSpaceEvent>((event, emit) async {
      String spaceId = event.spaceId;
      await set(spaceId, emit);
    });
    on<UpdateSpaceEvent>((event, emit) async {
      String spaceId = event.spaceId;

      if (state != null && state!.spaceId == spaceId) {
        await set(spaceId, emit);
      }
    });
  }

  Future<void> set(String spaceId, Emitter<Space?> emit) async {
    Space? space = await SpacesRepository().findById(spaceId);
    
    User? user = CurrentUserBloc().state;
    MemberView? memberView = await MemberViewsRepository().findByUserIdAndSpaceId(user!.userId!, spaceId);
    if (memberView != null) {
      CurrentMemberBloc().add(SetCurrentMemberEvent(memberView));
    }

    emit(space);
  }
}
