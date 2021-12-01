import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class EditItems extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback trailing;

  const EditItems({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        leading: Icon(
          icon,
          size: 30,
        ),
        trailing: SafeWidgetValidator(
          validators: [IsCurrentUserAdminWidgetValidator()],
          child: IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: trailing,
          ),
        ),
        horizontalTitleGap: 6,
      ),
    );
  }
}
