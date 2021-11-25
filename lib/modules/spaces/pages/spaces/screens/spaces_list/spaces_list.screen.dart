import 'package:badges/badges.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/space_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/utils/checkers.dart';
import 'package:demos_app/modules/spaces/pages/spaces/widgets/popup_spaces_menu_options.widget.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class SpaceListScreen extends StatelessWidget {
  final List<SpaceView> spaces;
  final List<SpaceView> invitations;

  const SpaceListScreen(
      {Key? key, required this.spaces, required this.invitations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: getTitle(),
            actions: [PopupSpacesMenuOptions()],
            bottom: getSpacesTabBar(),
          ),
          floatingActionButton: SafeWidgetValidator(
              child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.newSpace);
            },
            child: Icon(Icons.add),
          )),
          body: getBody(context)),
    );
  }

  Widget getBody(BuildContext context) {
    if (areOnlySpaceInvitations(spaces, invitations))
      return getInvitationList(context);
    if (areOnlySpaces(spaces, invitations)) return getSpaceList(context);

    return TabBarView(
      children: [
        getSpaceList(context),
        getInvitationList(context),
      ],
    );
  }

  Widget getSpaceList(BuildContext context) {
    return SpaceListWidget(
      spaces: spaces,
      getSubtitle: (spaceView) => '${spaceView.membersCount} miembros',
      onSpaceTab: (spaceView) async {
        await CurrentSpaceService().setCurrentSpace(spaceView.spaceId);

        Application.router.navigateTo(context, Routes.spacesDetails,
            routeSettings: RouteSettings(
              arguments: spaceView,
            ));
      },
    );
  }

  Widget getInvitationList(BuildContext context) {
    return SpaceListWidget(
      spaces: invitations,
      getSubtitle: (spaceView) =>
          'Fecha de expiración: ${DateFormatterService.parseToStandardDate(spaceView.invitationExpiredAt!)}',
      onSpaceTab: (spaceView) {
        Navigator.pushNamed(context, Routes.spaceInvitation,
            arguments: spaceView);
      },
    );
  }

  Widget getTitle() {
    if (areOnlySpaceInvitations(spaces, invitations))
      return Text('Tus Invitaciones');
    if (areOnlySpaces(spaces, invitations)) return Text('Tus Espacios');

    return Text('Demos');
  }

  PreferredSizeWidget? getSpacesTabBar() {
    if (requiresTabBar(spaces, invitations))
      return TabBar(
        tabs: [
          Tab(icon: Text('Espacios')),
          Tab(
              icon: Badge(
                  showBadge: invitations.length > 0,
                  elevation: 0,
                  position: BadgePosition(end: -28),
                  badgeContent: Text('${invitations.length}'),
                  child: Text('Invitaciones'))),
        ],
      );
  }
}
