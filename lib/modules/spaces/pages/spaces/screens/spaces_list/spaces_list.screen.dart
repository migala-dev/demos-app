import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/space_list.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/utils/checkers.dart';
import 'package:demos_app/modules/spaces/pages/spaces/widgets/popup_spaces_menu_options.widget.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/utils/navigation/go_to_space_details.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class SpaceListScreen extends StatelessWidget {
  final List<SpaceView> spaces;
  final List<InvitationView> invitations;

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
            child: const Icon(Icons.add),
          )),
          body: getBody(context)),
    );
  }

  Widget getBody(BuildContext context) {
    if (areOnlySpaceInvitations(spaces, invitations)) {
      return getInvitationList(context);
    }
    if (areOnlySpaces(spaces, invitations)) return getSpaceList(context);

    return TabBarView(
      children: [
        getSpaceList(context),
        getInvitationList(context),
      ],
    );
  }

  Widget getSpaceList(BuildContext context) {
    return SpaceListWidget<SpaceView>(
      spaces: spaces,
      getSubtitle: (spaceView) => '${spaceView.membersCount} miembros',
      onSpaceTab: (spaceView) async {
        await goToSpaceDetails(context, spaceView);
      },
    );
  }

  Widget getInvitationList(BuildContext context) {
    return SpaceListWidget<InvitationView>(
      spaces: invitations,
      getSubtitle: (invitationView) =>
          'Fecha de expiración: ${DateFormatterService.parseToStandardDate(invitationView.expiredAt)}',
      onSpaceTab: (invitationView) {
        Navigator.pushNamed(context, Routes.spaceInvitation,
            arguments: invitationView);
      },
    );
  }

  Widget getTitle() {
    if (areOnlySpaceInvitations(spaces, invitations)) {
      return const Text('Tus Invitaciones');
    }

    if (areOnlySpaces(spaces, invitations)) return const Text('Tus Espacios');

    return const Text('Demos');
  }

  PreferredSizeWidget? getSpacesTabBar() {
    if (requiresTabBar(spaces, invitations)) {
      return TabBar(
        tabs: [
          const Tab(icon: Text('Espacios')),
          Tab(
              icon: Badge(
                  showBadge: invitations.isNotEmpty,
                  elevation: 0,
                  position: const BadgePosition(end: -28),
                  badgeContent: Text('${invitations.length}'),
                  child: const Text('Invitaciones'))),
        ],
      );
    }
  }
}
