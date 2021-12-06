import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

Future<bool> existsContactInInvitedMembers(
    Contact contact, List<Member> invitedMembers) async {
  final contactPhoneNumber =
      contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');

  for (final member in invitedMembers) {
    final user = await UsersRepository().findById(member.userId!);
    if (user != null) {
      if (user.phoneNumber == contactPhoneNumber) {
        return true;
      } else if (user.phoneNumber.substring(3) == contactPhoneNumber) {
        return true;
      }
    }
  }

  return false;
}
