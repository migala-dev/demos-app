part of 'space_members_bloc.dart';

abstract class SpaceMembersEvent extends Equatable {
  const SpaceMembersEvent();

  @override
  List<Object> get props => [];
}

class LoadSpaceMembers extends SpaceMembersEvent {}

class UpdateSpaceMember extends SpaceMembersEvent {
  final String memberId;

  const UpdateSpaceMember(this.memberId);
}
