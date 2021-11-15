import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';

class MembersScreenService {
  Future<List<MemberView>> getMemberViews() async {
    final List<MemberView> memberViews = [];

    final Space? currentSpace = CurrentSpaceService().getCurrentSpace();
    final String? spaceId = currentSpace!.spaceId;

    final members = await MemberService().getSpaceMembers(spaceId!);
    for (final member in members) {
      final user = await UsersRepository().findById(member.userId!);
      final memberView = MemberView(
          userId: member.userId!,
          noParticipations: 0,
          role: member.role,
          createdAt: member.createdAt!,
          invitationStatus: member.invitationStatus,
          memberId: member.memberId,
          name: user?.name,
          spaceId: spaceId,
          phoneNumber: user?.phoneNumber,
          profilePictureKey: user?.profilePictureKey);

      memberViews.add(memberView);
    }

    return memberViews;
  }
}
