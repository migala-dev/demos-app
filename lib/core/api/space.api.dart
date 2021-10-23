import 'dart:io';

import 'package:demos_app/constans/space.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';

class SpaceApi {
  static SpaceApi _spaceApi = SpaceApi._internal();

  SpaceApi._internal();

  factory SpaceApi() {
    return _spaceApi;
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

    AcceptInvitationResponse response = AcceptInvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<InvitationResponse> rejectInvitation(String spaceId) async {
    String endpoint = SpacePath().getRejectInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null);

    InvitationResponse response = InvitationResponse.fromObject(httpResponse);

    return response;
  }
}
