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

import 'package:demos_app/modules/auth/screens/initial_profile.dart';
import 'package:demos_app/modules/auth/screens/login.dart';
import 'package:demos_app/modules/auth/screens/verify_phone.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/bloc/comment_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/cubit/comment_reply_cubit.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/proposal_comments.page.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/proposal_details.page.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form.page.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/screens/null_vote.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/screens/vote_proposal.screen.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';
import 'package:demos_app/shared/screens/edit_content.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/new_space.page.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/invitations.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/member_profile.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/members.screen.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/edit_space/edit_space.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_percentage/space_percentage_settings.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_settings/space_settings.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/spaces_details.page.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/space_invitation/space_invitation.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/pages/spaces/spaces.page.dart';
import 'package:demos_app/modules/spaces/screens/general_configuration.screen.dart';
import 'package:demos_app/modules/spaces/screens/general_settings.screen.dart';
import 'package:demos_app/modules/spaces/screens/profile.screen.dart';
import 'package:demos_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});

var splashHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const Splash();
});

var verifyPhoneHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const VerifyPhonePage();
});

var initialProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const InitialProfile();
});

var spacesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SpacesScreen();
});

var spaceDetailsHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  final Object? spaceArgument = context!.settings!.arguments;
  if (spaceArgument is String) {
    final String spaceId = spaceArgument;
    SpaceBloc().add(SetSpaceIdEvent(spaceId));
    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  } else {
    final SpaceView spaceView = spaceArgument as SpaceView;
    SpaceBloc().add(SetSpaceViewEvent(spaceView));
    ProposalViewListBloc().add(ProposalViewListLoaded(spaceView.spaceId!));
  }
  SpaceMembersBloc().add(LoadSpaceMembers());

  return const SpaceDetailsScreen();
});

var spaceSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SpaceSettingsScreen();
});

var spacePercentageSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SpacePercentageSettingsScreen();
});

var editSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const EditSpaceScreen();
});

var newSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const NewSpaceScreen();
});

var invitationsSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const InvitationsScreen();
});

var spaceInvitationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  final InvitationView invitationView =
      ModalRoute.of(context!)?.settings.arguments as InvitationView;

  return SpaceInvitationScreen(invitationView: invitationView);
});

var proposalFormHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ProposalFormScreen();
});

var editProposalContentHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return EditContentScreen(
    content: '',
  );
});

var proposalDetailsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  ProposalView proposalView = context!.settings!.arguments as ProposalView;

  CommentReplyCubit().cancelReply();
  CommentViewListBloc().add(CommentViewListEmpited());
  ProposalDetailsBloc().add(SetProposalViewEvent(proposalView));

  return const ProposalDetailsPage();
});

var generalSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const GeneralSettingsScreen();
});

var generalConfigurationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const GeneralConfigurationScreen();
});

var profileSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ProfileSettingScreen();
});

var spaceMembersHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SpaceMembersScreen();
});

var memberProfileHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  final memberView = context!.settings!.arguments as MemberView;
  return MemberProfileScreen(memberView);
});

var voteProposalHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  ProposalView proposalView = context!.settings!.arguments as ProposalView;
  return VoteProposalScreen(proposal: proposalView);
});

var nullVoteHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  ProposalView proposalView = context!.settings!.arguments as ProposalView;
  return NullVoteScreen(proposal: proposalView);
});

var proposalCommentsHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  CommentViewListBloc().add(CommentViewListLoaded());
  return const ProposalCommentsPage();
});

