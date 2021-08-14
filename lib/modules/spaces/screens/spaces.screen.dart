import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/models/space.dart';
import 'package:demos_app/widgets/spaces/spaces_listview.widget.dart';
import 'package:demos_app/widgets/spaces/popupSpacesMenuButton.widget.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Espacios'),
          actions: [PopupSpacesMenuButton()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: SpacesListView(invitations: testInvitations, spaces: testSpaces));
  }
}
