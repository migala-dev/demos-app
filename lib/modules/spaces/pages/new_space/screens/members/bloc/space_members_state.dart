part of 'space_members_bloc.dart';

abstract class SpaceMembersState extends Equatable {
  const SpaceMembersState();

  @override
  List<Object> get props => [];
}

class SpaceMembersLoadInProgress extends SpaceMembersState {}

class SpaceMembersWithData extends SpaceMembersState {
  final List<MemberView> memberViews;

  const SpaceMembersWithData(this.memberViews);
}
