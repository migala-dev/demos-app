import 'package:demos_app/config/routes/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static final String root = "/";
  static final String login = "/login";
  static final String verifyPhone = "/verify-code";
  static final String profile = "/profile";
  static final String spaces = "/spaces";
  static final String authLoading = "/auth-loading";
  static final String settings = "/settings";

  static void configureRoutes(FluroRouter router, String initialRoute) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    if (initialRoute == login) {
      router.define(root, handler: loginHandler);
    } else {
      router.define(root, handler: spacesHandler);
    }

    router.define(login, handler: loginHandler);
    router.define(verifyPhone, handler: verifyPhoneHandler);
    router.define(profile, handler: profileHandler);
    router.define(spaces, handler: spacesHandler);
    router.define(settings, handler: settingsHandler);
  }
}
