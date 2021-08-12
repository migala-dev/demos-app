import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:demos_app/core/auth/screens/login.dart';
import 'package:demos_app/core/auth/screens/profile.dart';
import 'package:demos_app/core/auth/screens/verify_phone.dart';
import 'package:demos_app/modules/home/screens/home.dart';

var homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

var verifyPhoneHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return VerifyPhonePage();
});

var profileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return Profile();
});
