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
import 'package:equatable/equatable.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/core/services/current_user/current_user.storage.dart';

part 'current_user_event.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, User?> {
  static final CurrentUserBloc _currentUserBloc = CurrentUserBloc._internal();
  factory CurrentUserBloc() {
    return _currentUserBloc;
  }

  CurrentUserBloc._internal() : super(null) {
    on<CurrentUserLoaded>((event, emit) async {
      if (state == null) {
        String? currentUserId = await CurrentUserStorage().getCurrentUserId();
        if (currentUserId != null) {
          User? user = await UsersRepository().findById(currentUserId);
          emit(user);
        }
      }
    });

    on<CurrentUserSetted>((event, emit) async {
      await CurrentUserStorage().setCurrentUserId(event.userId);

      add(CurrentUserLoaded());
    });

    on<CurrentUserUpdated>((event, emit) {
      emit(event.user);
    });
  }
}
