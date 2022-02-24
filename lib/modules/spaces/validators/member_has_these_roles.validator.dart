

import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class MemberHasTheseRolesValidator extends WidgetValidator {
  final MemberView member;
  final List<SpaceRole> roles;

  MemberHasTheseRolesValidator({ required this.member, required this.roles });

  @override
  Future<bool> canActivate() async {
    return roles.any((role) => member.role == role);
  }
}