import 'package:demos_app/modules/settings/screens/settings.screen.dart';
import 'package:demos_app/modules/spaces/screens/spaces.screen.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

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

var settingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SettingsScreen();
});
