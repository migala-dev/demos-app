import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/modules/settings/screens/general_settings.screen.dart';
import 'package:demos_app/modules/settings/screens/profile.screen.dart';
import 'package:demos_app/modules/spaces/screens/new_space.screen.dart';
import 'package:demos_app/modules/spaces/screens/spaces.screen.dart';
import 'package:demos_app/modules/spaces/screens/spaces_details_screen.dart';


import 'package:demos_app/core/auth/screens/login.dart';
import 'package:demos_app/core/auth/screens/initial_profile.dart';
import 'package:demos_app/core/auth/screens/verify_phone.dart';

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

var newSpaceHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return NewSpaceScreen();

});

var generalSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return GeneralSettingsScreen();
});

var profileSettingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ProfileSettingScreen();
});
