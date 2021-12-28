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

  SpaceMembersWithData copyWithMemberUpdate(MemberView updatedMember) {
    int memberIndex = memberViews
        .indexWhere((member) => member.memberId == updatedMember.memberId);
    if (memberIndex != -1) {
      memberViews.removeAt(memberIndex);
      memberViews.insert(memberIndex, updatedMember);
    }

    return SpaceMembersWithData([...memberViews]);
  }

  SpaceMembersWithData copyWithMemberDeleted(String memberId) {
    memberViews.removeWhere((member) => member.memberId == memberId);

    return SpaceMembersWithData([...memberViews]);
  }

  SpaceMembersWithData copyWithNewInvitation(MemberView newMember) {
    memberViews.add(newMember);

    return SpaceMembersWithData([...memberViews]);
  }

  bool hasRepresentative() =>
      memberViews.any((member) => member.role == SpaceRole.representative);
}
