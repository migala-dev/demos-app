import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/invitation_contact.model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  static Future<List<InvitationContact>> getInvitationContacts() async {
    List<InvitationContact> userContacts = [];
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      userContacts = await mapContactsToUser(contacts);
    }
    return userContacts;
  }

  static Future<List<InvitationContact>> mapContactsToUser(
      List<Contact> contacts) async {
    List<InvitationContact> userContacts = [];
    await Future.forEach(contacts, (Contact contact) async {
      if (contact.phones.length > 0) {
        String phoneNumber =
            contact.phones[0].number.replaceAll(new RegExp(r'[^0-9]'), '');
        if (phoneNumber.length >= 10) {
          User? user =
              await UsersRepository().getUserByPhoneNumber(phoneNumber);
          if (user == null) {
            InvitationContact userContact =
                new InvitationContact.withPhoneNumber(phoneNumber);
            userContact.name = contact.displayName;
            userContacts.add(userContact);
          } else {
            InvitationContact userContact = InvitationContact.fromUser(user);
            userContacts.add(userContact);
          }
        }
      }
    });

    return userContacts;
  }
}
