import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/responses/send_invitations_response.model.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/user_space.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';

class SpaceInvitationService {
  Future<List<UserSpace>> sendInvitations(
      String spaceId, List<InvitationContact> contacts) async {
    SendInvitationsResponse response =
        await SpaceApi().sendInvitations(spaceId, contacts);

    for (final member in response.userSpaces) {
      await UserSpaceRepository().insertOrUpdate(member);
    }

    return response.userSpaces;
  }

  Future<UserSpace?> acceptInvitation(String spaceId) async {
    AcceptInvitationResponse response =
        await SpaceApi().acceptInvitation(spaceId);

    await SpacesRepository().updateSpace(response.space);

    await UserSpaceRepository().update(response.userSpace);

    for (final member in response.members) {
      await UserSpaceRepository().insertOrUpdate(member);
    }

    for (final user in response.users) {
      await UsersRepository().insertOrUpdate(user);
    }

    for (final userRole in response.userRoles) {
      await RoleUserSpaceRepository().insert(userRole);
    }

    return response.userSpace;
  }

  Future<UserSpace?> rejectInvitation(String spaceId) async {
    InvitationResponse response = await SpaceApi().rejectInvitation(spaceId);

    await UserSpaceRepository().update(response.userSpace);

    return response.userSpace;
  }
}
