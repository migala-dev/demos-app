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

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';

bool isContactAlreadyOnTheSpace(Contact contact, List<MemberView> members) {
  if (contact.phones.isEmpty) {
    return true;
  }
  final contactPhoneNumber =
      contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');

  for (final member in members) {
    if (member.phoneNumber == null) {
      return false;
    }
    final userPhoneNumber = member.phoneNumber!.length > 10
        ? member.phoneNumber!.substring(3)
        : member.phoneNumber;

    if (contactPhoneNumber == userPhoneNumber) {
      return true;
    }
  }

  return false;
}
