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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/shared/services/phone_formatter.service.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class InvitationContactList extends StatelessWidget {
  final List<InvitationContact> contacts;
  final List<InvitationContact> contactsSelected;
  final String searchParam;
  final void Function(InvitationContact)? onContactTap;

  const InvitationContactList(
      {Key? key,
      required this.contacts,
      required this.contactsSelected,
      this.searchParam = '',
      this.onContactTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactsFiltered = getContactsFiltered();
    return ListView.builder(
        itemCount: contactsFiltered.length,
        itemBuilder: (BuildContext context, int position) {
          InvitationContact contact = contactsFiltered[position];
          return InkWell(
              onTap: () {
                if (onContactTap != null) {
                  onContactTap!(contact);
                }
              },
              child: Ink(
                color: Colors.white,
                child: ListTile(
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      getAvatar(contact),
                      getCheckCirculeIfUserIsSelected(contact),
                    ],
                  ),
                  title: Text(contact.name, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: primaryColor),),
                  subtitle: Container(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                    child:
                        Text(PhoneFormatterService.format(contact.phoneNumber), style: const TextStyle(fontSize: 12.0),),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: greyColor))),
                  ),
                ),
              ));
        });
  }

  List<InvitationContact> getContactsFiltered() {
    return contacts
        .where((c) => c.name.toLowerCase().contains(searchParam.toLowerCase()))
        .toList();
  }

  Widget getAvatar(InvitationContact user) {
    return ProfilePicture(
      imageKey: user.profilePictureKey,
      percentage: 0.12,
    );
  }

  String getInitials(String name) {
    return name[0];
  }

  Widget getCheckCirculeIfUserIsSelected(InvitationContact contact) {
    bool isContactSelected = contactsSelected.contains(contact);
    return Positioned(
        right: -4.0,
        bottom: -4.0,
        child: isContactSelected ? Container(
            width: 20.0 ,
            height: 20.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                color: secondaryColorLight),
            child: const Center(
              child: Icon(
                Icons.done,
                color: primaryColor,
                size: 14.0,
              ),
            )): Container());
  }
}
