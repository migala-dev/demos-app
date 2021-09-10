import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'package:demos_app/modules/spaces/widgets/popup_spaces_menu_button.widget.dart';
import 'package:demos_app/modules/spaces/widgets/spaces_scroll_view.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<SpacesBloc, SpacesState>(
        builder: (context, state) => Scaffold(
            appBar: _spacesAppBar(state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.newSpace);
              },
              child: Icon(Icons.add),
            ),
            body: TabBarView(
              children: [
                SpacesScrollView(spaces: state.spaces),
                SpacesScrollView(spaces: state.invitations),
              ],
            )),
      ),
    );
  }

  AppBar _spacesAppBar(SpacesState state) {
    return AppBar(
      title: Text('Demos'),
      actions: [PopupSpacesMenuButton()],
      bottom: TabBar(
        tabs: [
          Tab(icon: Text('Espacios')),
          Tab(
              icon: state.invitations.length == 0
                  ? Text('Invitaciones')
                  : Badge(
                      elevation: 0,
                      position: BadgePosition(end: -28),
                      badgeContent: Text('${state.invitations.length}'),
                      child: Text('Invitaciones'))),
        ],
      ),
    );
  }
}
