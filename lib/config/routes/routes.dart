import 'package:demos_app/config/routes/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String verifyPhone = "/verify-code";
  static String initialProfile = "/initial-profile";
  static String spaces = "/spaces";
  static String authLoading = "/auth-loading";

  static void configureRoutes(FluroRouter router, String initialRoute) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });

    var rootHandler = initialRoute == login ? loginHandler : homeHandler;
    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(verifyPhone, handler: verifyPhoneHandler);
    router.define(initialProfile, handler: initialProfileHandler);
    router.define(spaces, handler: homeHandler);
  }
}
