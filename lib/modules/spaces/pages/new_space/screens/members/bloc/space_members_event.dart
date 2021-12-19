part of 'space_members_bloc.dart';

abstract class SpaceMembersEvent extends Equatable {
  const SpaceMembersEvent();

  @override
  List<Object> get props => [];
}

class LoadSpaceMembers extends SpaceMembersEvent {}
