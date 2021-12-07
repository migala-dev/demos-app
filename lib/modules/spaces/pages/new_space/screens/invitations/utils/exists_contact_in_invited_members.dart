import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

Future<bool> isContactAlreadyOnTheSpace(
    Contact contact, List<Member> members) async {
  final contactPhoneNumber =
      contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');

  for (final member in members) {
    final user = await UsersRepository().findById(member.userId!);
    if (user != null) {
      final userPhoneNumber = user.phoneNumber.length > 10
          ? user.phoneNumber.substring(3)
          : user.phoneNumber;

      if (userPhoneNumber == contactPhoneNumber) {
        return true;
      }
    }
  }

  return false;
}
