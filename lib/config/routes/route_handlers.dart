import 'package:demos_app/core/auth/login/login.dart';
import 'package:demos_app/core/auth/login/verify_phone.dart';
import 'package:demos_app/modules/home/screens/home.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

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
