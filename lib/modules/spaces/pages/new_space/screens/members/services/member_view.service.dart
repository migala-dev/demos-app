import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/repositories/member_view.repository.dart';

class MemberViewService {
  Future<List<MemberView>> getMemberViews() async {
    final SpaceView currentSpace = SpaceBloc().state;
    final String spaceId = currentSpace.spaceId!;

    List<MemberView> members = await MemberViewsRepository().findMembersBySpaceId(spaceId);
    
    return members;
  }

  Future<MemberView?> getMemberViewByMemberId(String memberId) async {
    final memberView = await MemberViewsRepository().findByMemberId(memberId);

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
