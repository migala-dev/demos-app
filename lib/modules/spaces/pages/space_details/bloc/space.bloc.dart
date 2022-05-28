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

import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.event.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
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
    MemberView? memberView = await MemberViewsRepository().findByUserIdAndSpaceId(user!.userId, spaceId);
    if (memberView != null) {
      CurrentMemberBloc().add(SetCurrentMemberEvent(memberView));
    }
  }
}
