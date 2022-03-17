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

import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_tile.widget.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({
    Key? key,
    required this.memberViews,
  }) : super(key: key);

  final List<MemberView> memberViews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: memberViews.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final memberView = memberViews[index];

        return GestureDetector(
            child: MemberTile(member: memberView),
            onTap: () => goToMemberProfile(context, memberView));
      },
    );
  }

  void goToMemberProfile(BuildContext context, MemberView memberView) =>
      Application.router.navigateTo(
        context,
        Routes.memberProfile,
        routeSettings: RouteSettings(arguments: memberView),
      );
}
