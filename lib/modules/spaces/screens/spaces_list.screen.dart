import 'package:badges/badges.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/widgets/popup_spaces_menu_button.widget.dart';
import 'package:demos_app/modules/spaces/widgets/spaces_scroll_view.widget.dart';
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
            title: Text('Demos'),
            actions: [PopupSpacesMenuButton()],
            bottom: TabBar(
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
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.newSpace);
            },
            child: Icon(Icons.add),
          ),
          body: TabBarView(
            children: [
              SpacesScrollView(spaces: spaces),
              SpacesScrollView(spaces: invitations),
            ],
          )),
    );
  }
}
