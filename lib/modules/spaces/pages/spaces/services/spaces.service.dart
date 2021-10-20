import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/user_space.dart';
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
    List<SpaceView> spacesView = [];
    List<UserSpace> myUserSpaces =
        await UserSpaceRepository().findByInvitationStatus(invitationStatus);

    for (UserSpace userSpace in myUserSpaces) {
      Space? space = await SpacesRepository().findById(userSpace.spaceId!);
      List<UserSpace> members =
          await UserSpaceRepository().findBySpaceId(space!.spaceId);
      SpaceView spaceView = SpaceView(
          spaceId: space.spaceId ?? '',
          name: space.name ?? '',
          pictureKey: space.pictureKey,
          membersCount: members.length,
          createdAt: userSpace.createdAt);
      spacesView.add(spaceView);
    }

    return spacesView;
  }
}
