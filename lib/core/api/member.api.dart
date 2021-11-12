import 'package:demos_app/constans/member.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/responses/send_invitations_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';

class MemberApi {
  static final MemberApi _memberApi = MemberApi._internal();
  MemberApi._internal();

  factory MemberApi() {
    return _memberApi;
  }
    Future<AcceptInvitationResponse> acceptInvitation(String spaceId) async {
    String endpoint = MemberPath().getAcceptInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null);

    AcceptInvitationResponse response =
        AcceptInvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<InvitationResponse> rejectInvitation(String spaceId) async {
    String endpoint = MemberPath().getRejectInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null);

    InvitationResponse response = InvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<SendInvitationsResponse> sendInvitations(
      String spaceId, List<InvitationContact> contacts) async {
    String endpoint = MemberPath().getInvitationPath(spaceId);
    Object params = {"users": contacts.map((c) => c.toJson()).toList()};

    final httpResponse = await Api.post(endpoint, params);

    SendInvitationsResponse response =
        SendInvitationsResponse.fromObject(httpResponse);

    return response;
  }
}
