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
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/utils/exists_contact_in_invited_members.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  static Future<List<InvitationContact>> getInvitationContacts() async {
    List<InvitationContact> userContacts = [];
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      final filteredContacts = await getUninvitedContacts(contacts);

      userContacts = await mapContactsToUser(filteredContacts);
    }
    return userContacts;
  }

  static Future<List<Contact>> getUninvitedContacts(
      List<Contact> contacts) async {
    final List<Contact> filteredContacts = [];
    if (SpaceMembersBloc().state is SpaceMembersWithData) {
      final membersState = SpaceMembersBloc().state as SpaceMembersWithData;

      for (final contact in contacts) {
        if (!isContactAlreadyOnTheSpace(contact, membersState.memberViews)) {
          filteredContacts.add(contact);
        }
      }

      return filteredContacts;
    }

    return contacts;
  }

  static Future<List<InvitationContact>> mapContactsToUser(
      List<Contact> contacts) async {
    List<InvitationContact> userContacts = [];
    await Future.forEach(contacts, (Contact contact) async {
      if (contact.phones.isNotEmpty) {
        String phoneNumber =
            contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');
        if (phoneNumber.length >= 10) {
          InvitationContact userContact = InvitationContact(phoneNumber);
          userContact.name = contact.displayName;
          userContacts.add(userContact);
        }
      }
    });

    return userContacts;
  }
}
