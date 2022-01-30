import 'package:demos_app/modules/spaces/pages/space_details/widgets/no_representant_alert.widget.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class NoProposals extends StatelessWidget {
  NoProposals({Key? key}) : super(key: key);
  final color = Colors.grey.shade500;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.how_to_vote_outlined, size: 135, color: color),
        const SizedBox(height: 10),
        Text('Sin propuestas por el momento', style: TextStyle(color: color)),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeWidgetValidator(
              validators: [IsCurrentUserAdminWidgetValidator()],
              child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: NoRepresentantAlert())),
        )
      ],
    );
  }
}
