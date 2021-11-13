import 'package:demos_app/core/api/member.api.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/responses/send_invitations_response.model.dart';
import 'package:demos_app/core/models/member.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';

class MemberService {

  Future<List<Member>> sendInvitations(String spaceId, List<InvitationContact> contacts) async {
    SendInvitationsResponse response = await MemberApi().sendInvitations(spaceId, contacts);

    for (final member in response.members) {
      await MembersRepository().insertOrUpdate(member);
    }

    return response.members;
  }

  Future<void> acceptInvitation(String spaceId) async {
    AcceptInvitationResponse response = await MemberApi().acceptInvitation(spaceId);

    await SpacesRepository().updateSpace(response.space);

    for (final member in response.members) {
      await MembersRepository().insertOrUpdate(member);
    }

    for (final user in response.users) {
      await UsersRepository().insertOrUpdate(user);
    }
  }

  Future<Member?> rejectInvitation(String spaceId) async {
    InvitationResponse response = await MemberApi().rejectInvitation(spaceId);

    await MembersRepository().update(response.member);

    return response.member;
  }
}
