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

import 'package:demos_app/config/routes/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String root = '/';
  static const String splash = '/splash';
  // Authentification
  static const String login = '/login';
  static const String verifyPhone = '/verify-code';
  static const String initialProfile = '/initial-profile';
  static const String authLoading = '/auth-loading';
  // Spaces
  static const String spaces = '/spaces';
  static const String newSpace = '/new-space';
  static const String spacesDetails = '/spaces/spaces-details';
  static const String invitations = '/invitations';
  static const String spaceInvitation = '/space-invitation';
  static const String spaceSettings = '/spaces/space-settings';
  static const String spacePercentage = '/spaces/space-percentage';
  static const String spaceMembers = '/spaces/space-members';
  static const String editSpace = '/spaces/edit-space';
  static const String memberProfile = '/spaces/member-profile';

  // Proposals
  static const String proposalForm = '/proposal-form';
  static const String editProposalContent =
      '/new-proposal/edit-proposal-content';
  static const String proposalDetails = '/proposal-details';
  static const String voteProposal = '/vote-proposal';
  static const String nullVote = '/null-vote';
  static const String proposalComments = '/proposal-comment';

  // Settings
  static const String settings = '/settings/general';
  static const String configuration = '/settings/configuration';
  static const String profileSettings = '/settings/profile';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return;
    });

    router.define(root, handler: splashHandler);
    // Authentification
    router.define(login, handler: loginHandler);
    router.define(verifyPhone, handler: verifyPhoneHandler);
    router.define(initialProfile, handler: initialProfileHandler);
    // Spaces
    router.define(spaces, handler: spacesHandler);
    router.define(spacesDetails, handler: spaceDetailsHandler);
    router.define(newSpace, handler: newSpaceHandler);
    router.define(invitations, handler: invitationsSpaceHandler);
    router.define(spaceInvitation, handler: spaceInvitationHandler);
    router.define(spaceSettings, handler: spaceSettingsHandler);
    router.define(spacePercentage, handler: spacePercentageSettingsHandler);
    router.define(spaceMembers, handler: spaceMembersHandler);
    router.define(editSpace, handler: editSpaceHandler);
    router.define(memberProfile, handler: memberProfileHandler);

    // Proposals
    router.define(proposalForm, handler: proposalFormHandler);
    router.define(editProposalContent, handler: editProposalContentHandler);
    router.define(proposalDetails, handler: proposalDetailsHandler);
    router.define(voteProposal, handler: voteProposalHandler);
    router.define(nullVote, handler: nullVoteHandler);
    router.define(proposalComments, handler: proposalCommentsHandler);

    // Settings
    router.define(settings, handler: generalSettingsHandler);
    router.define(configuration, handler: generalConfigurationHandler);
    router.define(profileSettings, handler: profileSettingsHandler);
  }
}
