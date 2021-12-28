import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demos_app/core/api/user.api.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'current_user_event.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, User?> {
  final String _currentUserIdKey = 'current-user-id-key';
  final _storage = const FlutterSecureStorage();
  static final CurrentUserBloc _currentUserBloc = CurrentUserBloc._internal();
  factory CurrentUserBloc() {
    return _currentUserBloc;
  }

  CurrentUserBloc._internal() : super(null) {
    on<CurrentUserLoaded>((event, emit) async {
      if (state == null) {
        final currentUser = await getCurrentUser();
        emit(currentUser);
      }
    });

    on<CurrentUserSetted>((event, emit) async {
      await _storage.write(
          key: _currentUserIdKey, value: event.userId.toString());

      add(CurrentUserLoaded());
    });

    on<CurrentUserNameUpdated>((event, emit) async {
      User userSaved = await UserApi.updateUserName(event.newName);

      UsersRepository().updateUser(userSaved);

      emit(userSaved);
    });

    on<CurrentUserImageProfileUploaded>((event, emit) async {
      User? userSaved = await UserApi.uploadProfileImage(event.file);

      UsersRepository().updateUser(userSaved!);

      emit(userSaved);
    });
  }

  Future<User?> getCurrentUser() async {
    if (state == null) {
      String? currentUserId = await _storage.read(key: _currentUserIdKey);
      if (currentUserId != null) {
        User? user = await UsersRepository().findById(currentUserId);
        return user;
      }
    }

    return state;
  }
}
