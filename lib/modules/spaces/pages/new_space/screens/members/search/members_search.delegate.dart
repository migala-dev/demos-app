import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/members_screen.service.dart';

class MembersSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar miembros';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return _getNoResultsText();

    return _getWidgetResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Center(
        child: Icon(
          Icons.people,
          size: 50,
          color: Colors.grey,
        ),
      );

    return _getWidgetResult();
  }

  Widget _getWidgetResult() => FutureBuilder(
        future: MembersScreenService().findMembersByDisplayName(query),
        initialData: List<MemberView>.empty(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MemberView>> snapshot) {
          if (snapshot.hasData) {
            final List<MemberView> memberViews = snapshot.data ?? [];

            if (memberViews.length == 0) return _getNoResultsText();

            return MembersListView(memberViews: memberViews);
          }

          return _getNoResultsText();
        },
      );

  Widget _getNoResultsText() => Center(child: Text('No hay resultados'));
}
