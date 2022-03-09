import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';

Future<bool> isContactAlreadyOnTheSpace(
    Contact contact, List<MemberView> members) async {
  final contactPhoneNumber =
      contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');

  for (final member in members) {
    final userPhoneNumber = member.phoneNumber!.length > 10
        ? member.phoneNumber!.substring(3)
        : member.phoneNumber;

    if (contactPhoneNumber == userPhoneNumber) {
      return true;
    }
  }

  return false;
}
