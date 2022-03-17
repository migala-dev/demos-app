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

import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';

class MembersSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar miembros';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return _getNoResultsText();

    return _getWidgetResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.people,
          size: 50,
          color: Colors.grey,
        ),
      );
    }

    return _getWidgetResult();
  }

  Widget _getWidgetResult() => FutureBuilder(
        future: MemberViewService().findMembersByDisplayName(query),
        initialData: List<MemberView>.empty(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MemberView>> snapshot) {
          if (snapshot.hasData) {
            final List<MemberView> memberViews = snapshot.data ?? [];

            if (memberViews.isEmpty) return _getNoResultsText();

            return MembersListView(memberViews: memberViews);
          }

          return _getNoResultsText();
        },
      );

  Widget _getNoResultsText() => const Center(child: Text('No hay resultados'));
}
