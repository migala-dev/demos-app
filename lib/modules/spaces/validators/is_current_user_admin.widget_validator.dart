import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class IsCurrentUserAdminWidgetValidator implements WidgetValidator {
  @override
  Future<bool> canActivate() async {
    await Future.delayed(const Duration(milliseconds: 100));
    MemberView? currentMember = CurrentMemberBloc().state;

    return currentMember != null && currentMember.role == SpaceRole.admin;
  }
}
