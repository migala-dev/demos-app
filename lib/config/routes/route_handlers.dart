import 'package:demos_app/modules/auth/screens/initial_profile.dart';
import 'package:demos_app/modules/auth/screens/login.dart';
import 'package:demos_app/modules/auth/screens/verify_phone.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/new_proposal.page.dart';
import 'package:demos_app/modules/spaces/pages/new_space/new_space.page.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/invitations.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/member_profile.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/members.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/edit_space/edit_space.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_percentage/space_percentage_settings.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/screens/space_settings/space_settings.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/spaces_details.page.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/space_invitation/space_invitation.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
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
  final spaceView = context!.settings!.arguments as SpaceView;

  SpaceBloc().add(SetSpaceEvent(spaceView.spaceId));

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
  return const SpaceInvitationScreen();
});

var newProposalHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const NewProposalScreen();
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
