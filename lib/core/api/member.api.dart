/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/config/themes/cubit/throw_behavior.dart';
import 'package:demos_app/constans/member.path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/core/models/responses/accept_invitation_response.model.dart';
import 'package:demos_app/core/models/responses/invitation_response.model.dart';
import 'package:demos_app/core/models/responses/member_response.model.dart';
import 'package:demos_app/core/models/responses/members_and_phone_numbers_response.model.dart';
import 'package:demos_app/core/models/responses/send_invitations_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';

class MemberApi {
  static final MemberApi _memberApi = MemberApi._internal();
  MemberApi._internal();

  factory MemberApi() {
    return _memberApi;
  }
  Future<AcceptInvitationResponse> acceptInvitation(String spaceId) async {
    final String endpoint = MemberPath().getAcceptInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null, null);

    final AcceptInvitationResponse response =
        AcceptInvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<InvitationResponse> rejectInvitation(String spaceId) async {
    final String endpoint = MemberPath().getRejectInvitationPath(spaceId);
    final httpResponse = await Api.post(endpoint, null, null);

    final InvitationResponse response = InvitationResponse.fromObject(httpResponse);

    return response;
  }

  Future<SendInvitationsResponse> sendInvitations(
      String spaceId, List<InvitationContact> contacts) async {
    final String endpoint = MemberPath().getInvitationPath(spaceId);
    final Object params = {'users': contacts.map((c) => c.toJson()).toList()};

    final httpResponse = await Api.post(endpoint, params, null);

    final SendInvitationsResponse response =
        SendInvitationsResponse.fromObject(httpResponse);

    return response;
  }

  Future<MemberResponse> getMember(String spaceId, String memberId) async {
    final String endpoint = MemberPath().getMemberPath(spaceId, memberId);

    final httpResponse = await Api.get(endpoint, ThrowBehavior(showError: false));

    final MemberResponse response = MemberResponse.fromObject(httpResponse);

    return response;
  }

  Future<bool> updateMember(
      String spaceId, String memberId, String? name, SpaceRole role) async {
    final String endpoint = MemberPath().getMemberPath(spaceId, memberId);
    final Object params = {
      'name': name,
      'role': getSpaceRoleString(role),
    };
    
    await Api.post(endpoint, params, null);

    return true;
  }

  Future<void> deleteMember(String spaceId, String memberId) async {
    final String endpoint = MemberPath().getMemberPath(spaceId, memberId);
    await Api.delete(endpoint, null);
  }

  Future<void> cancelInvitation(String spaceId, String memberId) async {
    final String endpoint = MemberPath().getMemberInvitationPath(spaceId, memberId);
    await Api.delete(endpoint, null);
  }

  Future<void> leaveSpace(String spaceId) async {
    final String endpoint = MemberPath().getMembersSpacePath(spaceId);
    await Api.delete(endpoint, null);
  }

  Future<MemberPhoneNumbersResponse> getMemberPhoneNumbers(String spaceId) async {
    final String endpoint = MemberPath().getMembersPhoneNumbersPath(spaceId);

    final httpResponse = await Api.get(endpoint, ThrowBehavior(showError: false));

    final MemberPhoneNumbersResponse response = MemberPhoneNumbersResponse.fromObject(httpResponse);

    return response;
  }
}
