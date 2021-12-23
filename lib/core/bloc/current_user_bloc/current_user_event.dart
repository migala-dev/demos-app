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

class CurrentUserNameUpdated extends CurrentUserEvent {
  final String newName;

  const CurrentUserNameUpdated(this.newName);
}

class CurrentUserImageProfileUploaded extends CurrentUserEvent {
  final File file;

  const CurrentUserImageProfileUploaded(this.file);
}
