import 'dart:io';
import 'package:demos_app/constans/space.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/all_spaces_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/responses/send_invitations_response.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';

class SpaceApi {
  static SpaceApi _spaceApi = SpaceApi._internal();

  SpaceApi._internal();

  factory SpaceApi() {
    return _spaceApi;
  }

  Future<AllSpacesResponse> getAllSpaces() async {
    String endpoint = SpacePath().getAllSpaces();
    final httpResponse = await Api.get(endpoint);

    AllSpacesResponse response = AllSpacesResponse.fromObject(httpResponse);

    return response;
  }

  Future<SpaceResponse> createSpace(Space newSpace) async {
    String endpoint = SpacePath().getSpacesPath();
    Object params = {
      "name": newSpace.name,
      "description": newSpace.description,
      "participationPercentage": newSpace.participationPercentage.toString(),
      "approvalPercentage": newSpace.approvalPercentage.toString()
    };
    final httpResponse = await Api.post(endpoint, params);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }

  Future<void> updateSpace(Space space) async {
    String endpoint = SpacePath().getSpacePath(space.spaceId!);
    Object params = {
      "name": space.name,
      "description": space.description,
      "participationPercentage": space.participationPercentage.toString(),
      "approvalPercentage": space.approvalPercentage.toString()
    };
    await Api.post(endpoint, params);
  }

  Future<Space?> uploadPicture(String spaceId, File file) async {
    String endpoint = SpacePath().getUpdateSpaceImagePath(spaceId);

    final httpResponse = await Api.upload(endpoint, file);

    Space spaceUpdated = Space.fromObject(httpResponse);

    return spaceUpdated;
  }

  Future<SpaceResponse> getSpace(String spaceId) async {
    String endpoint = SpacePath().getSpacePath(spaceId);
    final httpResponse = await Api.get(endpoint);

    SpaceResponse response = SpaceResponse.fromObject(httpResponse);

    return response;
  }

  Future<AcceptInvitationResponse> acceptInvitation(String spaceId) async {
    String endpoint = SpacePath().getAcceptInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null);

    AcceptInvitationResponse response =
        AcceptInvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<InvitationResponse> rejectInvitation(String spaceId) async {
    String endpoint = SpacePath().getRejectInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null);

    InvitationResponse response = InvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<SendInvitationsResponse> sendInvitations(
      String spaceId, List<InvitationContact> contacts) async {
    String endpoint = SpacePath().getInvitationPath(spaceId);
    Object params = {"users": contacts.map((c) => c.toJson()).toList()};

    final httpResponse = await Api.post(endpoint, params);

    SendInvitationsResponse response =
        SendInvitationsResponse.fromObject(httpResponse);

    return response;
  }
}
