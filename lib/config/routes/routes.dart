import 'package:demos_app/config/routes/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static final String root = "/";
  // Authentification
  static final String login = "/login";
  static final String verifyPhone = "/verify-code";
  static final String initialProfile = "/initial-profile";
  static final String authLoading = "/auth-loading";
  // Spaces
  static final String spaces = "/spaces";
  static final String newSpace = "/new-space";
  static final String spacesDetails = "/spaces/spaces-details";
  static final String invitations = "/invitations";
  static final String spaceInvitation = '/space-invitation';
  static final String spaceSettings = '/spaces/space-settings';
  static final String spacePercentage = '/spaces/space-percentage';
  static final String spaceMembers = '/spaces/space-members';
  static final String memberProfile = '/spaces/member-profile';

  // Settings
  static final String settings = "/settings/general";
  static final String settingsProfile = "/settings/profile";

  static void configureRoutes(FluroRouter router, String initialRoute) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });

    var rootHandler = initialRoute == login ? loginHandler : spacesHandler;
    router.define(root, handler: rootHandler);
    // Authentification
    router.define(login, handler: loginHandler);
    router.define(verifyPhone, handler: verifyPhoneHandler);
    router.define(initialProfile, handler: initialProfileHandler);
    // Spaces
    router.define(spaces, handler: spacesHandler);
    router.define(spacesDetails, handler: spaceDetailsHandler);
    router.define(newSpace, handler: newSpaceHandler);
    router.define(invitations, handler: invitationsSpaceHandler);
    router.define(spaceInvitation, handler: spaceInvitationHandler);
    router.define(spaceSettings, handler: spaceSettingsHandler);
    router.define(spacePercentage, handler: spacePercentageSettingsHandler);
    router.define(spaceMembers, handler: spaceMembersHandler);
    router.define(memberProfile, handler: memberProfileHandler);

    // Settings
    router.define(settings, handler: generalSettingsHandler);
    router.define(settingsProfile, handler: profileSettingsHandler);
  }
}
