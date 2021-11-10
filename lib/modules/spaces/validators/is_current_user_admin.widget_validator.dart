import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/services/current_user.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class IsCurrentUserAdminWidgetValidator implements WidgetValidator {
  @override
  Future<bool> canActivate() async {
    Space? space = CurrentSpaceService().getCurrentSpace();

    if (space == null) {
      return false;
    }

    User? user = await CurrentUserService().getCurrentUser();
    RoleUserSpace? userRole = await RoleUserSpaceRepository()
        .findByUserIdAndSpaceId(user!.userId!, space.spaceId!);

    return userRole != null ? userRole.role == SpaceRole.ADMIN : false;
  }
}
