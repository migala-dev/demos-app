import 'package:badges/badges.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/spaces_scroll_view.widget.dart';
import 'package:demos_app/modules/spaces/pages/spaces/utils/checkers.dart';
import 'package:demos_app/modules/spaces/pages/spaces/widgets/popup_spaces_menu_button.widget.dart';
import 'package:demos_app/widgets/wrappers/top_snakbars_notification.dart';
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
            actions: [PopupSpacesMenuButton()],
            bottom: getSpacesTabBar(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.newSpace);
            },
            child: Icon(Icons.add),
          ),
          body: getBody()),
    );
  }

  Widget getBody() {
    if (areOnlySpaceInvitations(spaces, invitations))
      return SpacesScrollView(spaces: invitations);
    if (areOnlySpaces(spaces, invitations))
      return SpacesScrollView(spaces: spaces);

    return TopSnakbarsNotification(
      child: TabBarView(
        children: [
          SpacesScrollView(spaces: spaces),
          SpacesScrollView(spaces: invitations),
        ],
      ),
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
