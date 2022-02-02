import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/modules/spaces/validators/member_has_these_roles.validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SafeWidgetMemberValidator extends StatelessWidget {
  final List<SpaceRole> roles;
  final Widget child;

  const SafeWidgetMemberValidator(
      {Key? key, required this.roles, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentMemberBloc, MemberView?>(
      bloc: CurrentMemberBloc(),
      builder: (context, member) {
        if (member == null) {
          return Container();
        }
        return SafeWidgetValidator(
          child: child,
          validators: [
            MemberHasTheseRolesValidator(member: member, roles: roles)
          ],
        );
      },
    );
  }
}
