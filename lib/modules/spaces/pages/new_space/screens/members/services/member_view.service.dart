import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';

class MemberViewService {
  Future<List<MemberView>> getMemberViews() async {
    final List<MemberView> memberViews = [];

    final SpaceView currentSpace = SpaceBloc().state;
    final String? spaceId = currentSpace.spaceId;

    final members = await MemberService().getSpaceMembers(spaceId!);
    for (final member in members) {
      final user = await UsersRepository().findById(member.userId!);
      final memberView = MemberView(
          userId: member.userId!,
          memberName: member.name,
          participationCount: 0,
          role: member.role,
          memberCreatedAt: member.createdAt,
          invitationStatus: member.invitationStatus,
          memberId: member.memberId,
          userName: user?.name,
          spaceId: spaceId,
          phoneNumber: user?.phoneNumber,
          profilePictureKey: user?.profilePictureKey,
          invitationExpiredAt: member.expiredAt);

      memberViews.add(memberView);
    }

    return memberViews;
  }

  Future<MemberView?> getMemberViewByMemberId(String memberId) async {
    final member = await MemberService().getMemberByMemberId(memberId);
    if (member == null) return null;
    final user = await UsersRepository().findById(member.userId!);
    if (user == null) return null;

    final memberView = MemberView(
        userId: member.userId!,
        memberName: member.name,
        participationCount: 0,
        role: member.role,
        memberCreatedAt: member.createdAt,
        invitationStatus: member.invitationStatus,
        memberId: member.memberId,
        userName: user.name,
        spaceId: member.spaceId,
        phoneNumber: user.phoneNumber,
        profilePictureKey: user.profilePictureKey,
        invitationExpiredAt: member.expiredAt);

    return memberView;
  }

  Future<List<MemberView>> findMembersByDisplayName(String displayName) async {
    final memberViews = await getMemberViews();

    return memberViews.where((member) {
      final memberDisplayName = member.displayName.toLowerCase();
      final displayNameLowerCase = displayName.toLowerCase();

      return memberDisplayName.contains(displayNameLowerCase);
    }).toList();
  }
}
