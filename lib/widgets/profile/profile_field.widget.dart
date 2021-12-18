import 'package:flutter/material.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  final bool editable;
  final VoidCallback? onEdit;
  final String placeholderPrefix;
  final List<WidgetValidator>? editableButtonValidators;

  const ProfileField(
      {Key? key,
      required this.title,
      required this.icon,
      this.value,
      this.editable = false,
      this.placeholderPrefix = 'Introduce tu',
      this.onEdit,
      this.editableButtonValidators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.only(top: 6.0),
        child: Icon(icon),
      ),
      trailing: editable
          ? SafeWidgetValidator(
              validators: editableButtonValidators,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: onEdit == null ? Colors.grey : accentColor,
                ),
                onPressed: onEdit,
              ))
          : const SizedBox(
              height: 14,
              width: 14,
            ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
      subtitle: hasValue() ? getValueLabel() : getWithoutValueLabel(),
    );
  }

  bool hasValue() {
    return value != null && value != '';
  }

  Widget getValueLabel() {
    return Text(value ?? '',
        style: const TextStyle(color: Colors.black, fontSize: 18));
  }

  Widget getWithoutValueLabel() {
    return Text('$placeholderPrefix ${title.toLowerCase()}',
        style: const TextStyle(color: Colors.black26, fontSize: 18));
  }
}
