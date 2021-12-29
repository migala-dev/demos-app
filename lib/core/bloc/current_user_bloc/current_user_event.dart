part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserLoaded extends CurrentUserEvent {}

class CurrentUserSetted extends CurrentUserEvent {
  final String userId;

  const CurrentUserSetted(this.userId);
}

class CurrentUserUpdated extends CurrentUserEvent {
  final User? user;

  const CurrentUserUpdated(this.user);
}
