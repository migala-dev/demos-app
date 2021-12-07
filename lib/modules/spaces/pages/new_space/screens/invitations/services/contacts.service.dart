import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/models/invitation_contact.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/invitations/utils/exists_contact_in_invited_members.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
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
    final spaceId = CurrentSpaceService().getCurrentSpace()!.spaceId!;

    final members =
        await MembersRepository().findInvitedMembersBySpaceId(spaceId);

    for (final contact in contacts) {
      if (!await isContactAlreadyOnTheSpace(contact, members)) {
        filteredContacts.add(contact);
      }
    }

    return filteredContacts;
  }

  static Future<List<InvitationContact>> mapContactsToUser(
      List<Contact> contacts) async {
    List<InvitationContact> userContacts = [];
    await Future.forEach(contacts, (Contact contact) async {
      if (contact.phones.isNotEmpty) {
        String phoneNumber =
            contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');
        if (phoneNumber.length >= 10) {
          User? user =
              await UsersRepository().getUserByPhoneNumber(phoneNumber);
          if (user == null) {
            InvitationContact userContact =
                InvitationContact.withPhoneNumber(phoneNumber);
            userContact.name = contact.displayName;
            userContacts.add(userContact);
          } else {
            InvitationContact userContact = InvitationContact.fromUser(user);
            if (userContact.name == '') {
              userContact.name = contact.displayName;
            }
            userContacts.add(userContact);
          }
        }
      }
    });

    return userContacts;
  }
}
