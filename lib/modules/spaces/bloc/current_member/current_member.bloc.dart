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

import 'package:demos_app/modules/spaces/bloc/current_member/current_member.event.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentMemberBloc extends Bloc<CurrentMemberEvent, MemberView?> {
  static final CurrentMemberBloc _currentMemberBloc = CurrentMemberBloc._internal();
  factory CurrentMemberBloc() => _currentMemberBloc;

  CurrentMemberBloc._internal(): super(null) {
    on<SetCurrentMemberEvent>((event, emit) => emit(event.memberView));
  }
}