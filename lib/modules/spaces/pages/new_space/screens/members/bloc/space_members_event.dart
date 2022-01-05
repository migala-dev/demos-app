part of 'space_members_bloc.dart';

abstract class SpaceMembersEvent extends Equatable {
  const SpaceMembersEvent();

  @override
  List<Object> get props => [];
}

class LoadSpaceMembers extends SpaceMembersEvent {}

class SpaceMemberUpdated extends SpaceMembersEvent {
  final String memberId;

  const SpaceMemberUpdated(this.memberId);
}

class SpaceMemberDeleted extends SpaceMembersEvent {
  final String userId;

  const SpaceMemberDeleted(this.userId);
}
