import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
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
