import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

class SpaceService {
  static SpaceService _spaceService = new SpaceService._internal();

  SpaceService._internal();

  factory SpaceService() {
    return _spaceService;
  }

  Future<List<SpaceView>> getSpaces() {
    return _getSpacesByInvitationStatus(InvitationStatus.ACCEPTED);
  }

  Future<List<SpaceView>> getInvitations() {
    return _getSpacesByInvitationStatus(InvitationStatus.RECEIVED);
  }

  Future<List<SpaceView>> _getSpacesByInvitationStatus(
      InvitationStatus invitationStatus) async {
    User? currentUser = await CurrentUserService().getCurrentUser();
    List<SpaceView> spacesView = [];
    List<Member> myMemberships =
        await MembersRepository().findByInvitationStatusAndUserId(invitationStatus, currentUser!.userId!);

    for (Member member in myMemberships) {
      Space? space = await SpacesRepository().findById(member.spaceId!);
      List<Member> members =
          await MembersRepository().findBySpaceIdAndInvitationStatus(space!.spaceId, InvitationStatus.ACCEPTED);
      SpaceView spaceView = SpaceView(
          spaceId: space.spaceId ?? '',
          name: space.name ?? '',
          pictureKey: space.pictureKey,
          membersCount: members.length,
          invitationCreatedAt: member.createdAt,
          invitationExpiredAt: member.expiredAt);
      spacesView.add(spaceView);
    }

    return spacesView;
  }
}
