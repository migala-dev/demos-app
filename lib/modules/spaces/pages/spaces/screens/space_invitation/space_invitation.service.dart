
import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:demos_app/core/repositories/user_space.dart';

class SpaceInvitationService {

    Future<UserSpace?> rejectSpace(String spaceId) async {
      InvitationResponse response = await SpaceApi().rejectInvitation(spaceId);

      await UserSpaceRepository().update(response.userSpace);

      return response.userSpace;
    }
}