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
