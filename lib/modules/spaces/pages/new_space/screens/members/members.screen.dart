import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/search/members_search.delegate.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/members_screen.service.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/member_type_filter.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/models/member.view.dart';

class SpaceMembersScreen extends StatefulWidget {
  const SpaceMembersScreen({Key? key}) : super(key: key);

  @override
  State<SpaceMembersScreen> createState() => _SpaceMembersScreenState();
}

class _SpaceMembersScreenState extends State<SpaceMembersScreen> {
  bool isLoading = true;
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
                MemberTypeFilter(
                  selected: filter,
                  onFilteredMembersChange: _onFilteredMembersChange,
                ),
                Expanded(child: MembersListView(memberViews: filteredMembers))
              ],
            ),
    );
  }

  Future<void> _getMembers() async {
    setState(() {
      isLoading = true;
    });

    final spacesMembersService = MembersScreenService();
    final membersResult = await spacesMembersService.getMemberViews();
    members = membersResult;

    setState(() {
      isLoading = false;
    });
  }

  void _onFilteredMembersChange(MemberType newFilter) => setState(() {
        filter = newFilter;
      });

  List<MemberView> _getMembersFiltered(MemberType filter) {
    if (filter == MemberType.ALL) return this.members;

    return members.where((member) => filter == member.memberType).toList();
  }
}
