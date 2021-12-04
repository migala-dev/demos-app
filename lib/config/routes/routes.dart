import 'package:demos_app/config/routes/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String root = '/';
  // Authentification
  static const String login = '/login';
  static const String verifyPhone = '/verify-code';
  static const String initialProfile = '/initial-profile';
  static const String authLoading = '/auth-loading';
  // Spaces
  static const String spaces = '/spaces';
  static const String newSpace = '/new-space';
  static const String spacesDetails = '/spaces/spaces-details';
  static const String invitations = '/invitations';
  static const String spaceInvitation = '/space-invitation';
  static const String spaceSettings = '/spaces/space-settings';
  static const String spacePercentage = '/spaces/space-percentage';
  static const String spaceMembers = '/spaces/space-members';
  static const String memberProfile = '/spaces/member-profile';

  // Settings
  static const String settings = '/settings/general';
  static const String configuration = '/settings/configuration';
  static const String profileSettings = '/settings/profile';

  static void configureRoutes(FluroRouter router, String initialRoute) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
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
    router.define(configuration, handler: generalConfigurationHandler);
    router.define(profileSettings, handler: profileSettingsHandler);
  }
}
