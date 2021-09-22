part of 'spaces_bloc.dart';

abstract class SpacesEvent extends Equatable {
  const SpacesEvent();

  @override
  List<Object> get props => [];
}

class SpacesAddSpaceInvitation extends SpacesEvent {
  final SpaceView invitation;

  SpacesAddSpaceInvitation(this.invitation);
}

class InitSpaces extends SpacesEvent {}
