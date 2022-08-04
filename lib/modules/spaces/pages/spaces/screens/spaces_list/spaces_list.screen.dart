/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/config/custom-icons/demos_icons_icons.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/widgets/general/cache_refresh_indicator.widget.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
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

class SpaceListScreen extends StatefulWidget {
  final List<SpaceView> spaces;
  final List<InvitationView> invitations;

  const SpaceListScreen(
      {Key? key, required this.spaces, required this.invitations})
      : super(key: key);

  @override
  State<SpaceListScreen> createState() => _SpaceListScreenState();
}

class _SpaceListScreenState extends State<SpaceListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: getTitle(),
          actions: [PopupSpacesMenuOptions()],
        ),
        backgroundColor: primaryColor,
        floatingActionButton: SafeWidgetValidator(
            child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.newSpace);
          },
          child: const Icon(
            DemosIcons.add_space,
            color: Colors.black,
          ),
        )),
        body: CacheRefreshIndicator(
            child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 32.0, right: 8.0, left: 8.0, top: 4.0),
                child: CardWidget(child: getBody(context)))));
  }

  Widget getBody(BuildContext context) {
    if (areOnlySpaceInvitations(widget.spaces, widget.invitations)) {
      return getInvitationList();
    }
    if (areOnlySpaces(widget.spaces, widget.invitations)) {
      return getSpaceList();
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          height: 40,
          decoration: BoxDecoration(
            color: secondaryColorDark,
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
          child: TabBar(
            controller: _tabController,
            // give the indicator a decoration (color and border radius)
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: Colors.white,
            ),
            labelColor: primaryColor,
            unselectedLabelColor: primaryColor,

            tabs: [
              const Tab(
                text: 'TUS ESPACIOS',
              ),
              Tab(
                  icon: Badge(
                      showBadge: widget.invitations.isNotEmpty,
                      elevation: 0,
                      badgeColor: primaryColor,
                      position: const BadgePosition(end: -20),
                      badgeContent: Text(
                        widget.invitations.length.toString(),
                        style: const TextStyle(
                            fontSize: 10.0, color: Colors.white),
                      ),
                      child: const Text('INVITACIONES'))),
            ],
          ),
        ),
        // tab bar view here
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              getSpaceList(),
              getInvitationList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget getSpaceList() {
    return SpaceListWidget<SpaceView>(
      spaces: widget.spaces,
      getSubtitle: (spaceView) => '${spaceView.membersCount} miembros',
      onSpaceTab: (spaceView) async {
        await goToSpaceDetails(spaceView);
      },
    );
  }

  Widget getInvitationList() {
    return SpaceListWidget<InvitationView>(
      spaces: widget.invitations,
      getSubtitle: (invitationView) =>
          'Expira el ${DateFormatterService.parseToStandardDate(invitationView.expiredAt)}',
      onSpaceTab: (invitationView) {
        Navigator.pushNamed(context, Routes.spaceInvitation,
            arguments: invitationView);
      },
    );
  }

    Widget getTitle() {
    if (areOnlySpaceInvitations(widget.spaces, widget.invitations)) {
      return const Text('Tus Invitaciones');
    }

    if (areOnlySpaces(widget.spaces, widget.invitations)) return const Text('Tus Espacios');

    return const Text('Demos');
  }
}
