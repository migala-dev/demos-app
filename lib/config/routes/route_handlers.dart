import 'package:demos_app/modules/auth/screens/initial_profile.dart';
import 'package:demos_app/modules/auth/screens/login.dart';
import 'package:demos_app/modules/auth/screens/verify_phone.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/proposal_comments.page.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/screens/proposal_subcomment.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/proposal_details.page.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form.page.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';
import 'package:demos_app/shared/screens/edit_content.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/new_space.page.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/invitations.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/member_profile.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/members.screen.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
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
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
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

// Handler de los detalles del espacio
var spaceDetailsHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  Object? spaceArgument = context!.settings!.arguments;
  if (spaceArgument is String) {
    String spaceId = spaceArgument;
    SpaceBloc().add(SetSpaceIdEvent(spaceId));
    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  } else {
    SpaceView spaceView = spaceArgument as SpaceView;
    SpaceBloc().add(SetSpaceViewEvent(spaceView));
    ProposalViewListBloc().add(ProposalViewListLoaded(spaceView.spaceId!));
  }

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
  SpaceMembersBloc().add(LoadSpaceMembers());
  return const SpaceMembersScreen();
});

var memberProfileHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  final memberView = context!.settings!.arguments as MemberView;
  return MemberProfileScreen(memberView);
});

var proposalCommentsHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  return const ProposalCommentsPage();
});

var proposalSubCommentHandler =
    Handler(handlerFunc: (BuildContext? context, Object params) {
  return const ProposalSubCommentScreen();
});
