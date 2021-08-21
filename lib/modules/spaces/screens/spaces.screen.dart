import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'package:demos_app/modules/spaces/widgets/popup_spaces_menu_button.widget.dart';
import 'package:demos_app/modules/spaces/widgets/spaces_scroll_view.widget.dart';
import 'package:demos_app/modules/spaces/models/space.model.dart';

final testInvitations = [
  Space(name: 'Cooperativa #1', members: 5),
  Space(name: 'Cooperativa #3', members: 5),
  Space(name: 'Cooperativa #56', members: 5),
  Space(name: 'Cooperativa #6', members: 5),
];

final testSpaces = [
  Space(name: 'Cooperativa #21', members: 5),
  Space(name: 'Cooperativa #64', members: 5),
  Space(name: 'Cooperativa #88', members: 5),
  Space(name: 'Cooperativa #48', members: 5),
  Space(name: 'Cooperativa #12', members: 5),
  Space(name: 'Cooperativa #13', members: 5),
  Space(name: 'Cooperativa #14', members: 5),
];

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Espacios'),
            actions: [PopupSpacesMenuButton()],
            bottom: TabBar(
              tabs: [
                Tab(icon: Text('Espacios')),
                Tab(
                    icon: Badge(
                        elevation: 0,
                        position: BadgePosition(end: -20),
                        badgeContent: Text('${testInvitations.length}'),
                        child: Text('Invitaciones'))),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          body: TabBarView(
            children: [
              SpacesScrollView(spaces: testSpaces),
              SpacesScrollView(spaces: testInvitations),
            ],
          )),
    );
    // body: SpacesListView(invitations: testInvitations, spaces: testSpaces));
  }
}
