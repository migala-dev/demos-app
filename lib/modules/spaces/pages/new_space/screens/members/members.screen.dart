import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/search/members_search.delegate.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_filter.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';

class SpaceMembersScreen extends StatefulWidget {
  const SpaceMembersScreen({Key? key}) : super(key: key);

  @override
  State<SpaceMembersScreen> createState() => _SpaceMembersScreenState();
}

class _SpaceMembersScreenState extends State<SpaceMembersScreen>
    with LoadingStateHandler {
  MemberType filter = MemberType.ALL;

  List<MemberView> members = [];

  @override
  void initState() {
    super.initState();
    _getMembers();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = _getMembersFiltered(filter);

    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros'),
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                    context: context, delegate: MembersSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 70,
                  child: MemberTypeFilter(
                    selected: filter,
                    onFilteredMembersChange: _onFilteredMembersChange,
                  ),
                ),
                Expanded(child: MembersListView(memberViews: filteredMembers))
              ],
            ),
      floatingActionButton: SafeWidgetValidator(
        validators: [IsCurrentUserAdminWidgetValidator()],
        child: FloatingActionButton(
            child: Icon(Icons.person_add),
            onPressed: () => Navigator.pushNamed(context, Routes.invitations)),
      ),
    );
  }

  Future<void> _getMembers() async {
    wrapLoadingTransaction(() async {
      final spacesMembersService = MemberViewService();
      final membersResult = await spacesMembersService.getMemberViews();
      members = membersResult;
    });
  }

  void _onFilteredMembersChange(MemberType newFilter) => setState(() {
        if (filter == newFilter) {
          filter = MemberType.ALL;
        } else {
          filter = newFilter;
        }
      });

  List<MemberView> _getMembersFiltered(MemberType filter) {
    if (filter == MemberType.ALL) return this.members;

    return members.where((member) => filter == member.memberType).toList();
  }
}
