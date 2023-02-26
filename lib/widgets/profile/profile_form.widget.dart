/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/config/custom-icons/demos_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:demos_app/widgets/profile/profile_field.widget.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:url_launcher/url_launcher.dart';

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
          icon: DemosIcons.person,
          onEdit: () async {
            String? newName = await openUpdateNameModal(context);
            if (newName != null && user?.name != newName) {
              onEditNamePress!(newName);
            }
          },
          editable: onEditNamePress != null,
          value: user?.name,
        ),
        ProfileField(
          title: 'Teléfono',
          icon: DemosIcons.phone,
          value: formatPhoneNumber(user?.phoneNumber),
        ),
        GestureDetector(
          child: const ProfileField(
            title: 'Ver nuestras',
            value: 'Politicas de Privacidad',
            icon: DemosIcons.info_outlined,
          ),
          onTap: (() async {
            const String url = 'https://demos-migala.com/privacidad';
            final Uri uri = Uri.parse(url);

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'No se pudo abrir $url';
            }
          }),
        ),
      ],
    );
  }

  String formatPhoneNumber(String? phoneNumber) {
    String phoneNumberFormatted = '';

    if (phoneNumber != null) {
      phoneNumberFormatted = phoneNumber.substring(0, 3) +
          ' (' +
          phoneNumber.substring(3, 6) +
          ') ' +
          phoneNumber.substring(6, 9) +
          '-' +
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
