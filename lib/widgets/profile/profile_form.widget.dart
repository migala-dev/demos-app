import 'package:flutter/material.dart';
import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/core/models/user.model.dart';

class ProfileForm extends StatelessWidget {
  final void Function(String?)? onEditNamePress;
  final User? user;

  const ProfileForm({Key? key, this.onEditNamePress, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileField(
          title: 'Nombre',
          icon: Icons.person,
          onEdit: () async {
            String? newName = await openUpdateNameModal(context);
            if (newName != null && user?.name != newName) {
              this.onEditNamePress!(newName);
            }
          },
          editable: onEditNamePress != null,
          value: user?.name,
        ),
        ProfileField(
          title: 'Teléfono',
          icon: Icons.phone,
          value: formatPhoneNumber(user?.phoneNumber),
        ),
      ],
    );
  }

  String formatPhoneNumber(String? phoneNumber) {
    String phoneNumberFormatted = '';

    if (phoneNumber != null) {
      phoneNumberFormatted = phoneNumber.substring(0, 3) +
          " (" +
          phoneNumber.substring(3, 6) +
          ") " +
          phoneNumber.substring(6, 9) +
          "-" +
          phoneNumber.substring(9, phoneNumber.length);
    }

    return phoneNumberFormatted;
  }

  Future<String?> openUpdateNameModal(BuildContext context) async {
    return await openUpdateStringFieldModal(context,
        title: 'Nombre',
        hintText: 'Introduce tu nombre',
        initialValue: user?.name);
  }
}
