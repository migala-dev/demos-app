import 'package:demos_app/modules/auth/screens/initial_profile.dart';
import 'package:demos_app/modules/auth/screens/login.dart';
import 'package:demos_app/modules/auth/screens/verify_phone.dart';
import 'package:demos_app/modules/spaces/pages/new_space/new_space.page.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/invitations.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/space_settings.screen.dart';
import 'package:demos_app/modules/spaces/pages/space_details/spaces_details.page.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/space_invitation.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/spaces.page.dart';
import 'package:demos_app/modules/spaces/screens/general_settings.screen.dart';
import 'package:demos_app/modules/spaces/screens/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

var verifyPhoneHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return VerifyPhonePage();
});

var initialProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return InitialProfile();
});

var spacesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SpacesScreen();
});

// Handler de los detalles del espacio
var spaceDetailsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SpaceDetails();
});

var spaceSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SpaceSettings();
});

var newSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return NewSpaceScreen();
});

var invitationsSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return InvitationsScreen();
});

var spaceInvitationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SpaceInvitationScreen();
});

var generalSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return GeneralSettingsScreen();
});

var profileSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ProfileSettingScreen();
});
