import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class MemberProfilePopupMenuButton extends StatelessWidget {
  const MemberProfilePopupMenuButton({Key? key, required this.memberIsInvited})
      : super(key: key);

  final bool memberIsInvited;

  @override
  Widget build(BuildContext context) {
    return SafeWidgetValidator(
      validators: [IsCurrentUserAdminWidgetValidator()],
      child: PopupMenuButton(
        itemBuilder: (context) => [
          memberIsInvited
              ? PopupMenuItem(
                  child: Text("Cancelar Invitación"),
                  value: 0,
                )
              : PopupMenuItem(
                  child: Text("Eliminar Miembro"),
                  value: 1,
                ),
        ],
      ),
    );
  }
}
