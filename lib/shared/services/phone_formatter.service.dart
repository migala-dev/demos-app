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

class PhoneFormatterService {
  static String format(String? phoneNumber) {
    if (phoneNumber == null) {
      return '';
    }
    if (phoneNumber.length >= 10) {
      String formattedPhoneNumber = '';
      String remainingPhoneNumber = phoneNumber;

      if (phoneNumber.startsWith('+') || phoneNumber.length >= 12) {
        int plusDifference = phoneNumber.startsWith('+') ? 1 : 0;
        formattedPhoneNumber +=
            phoneNumber.substring(0, 2 + plusDifference) + ' ';
        remainingPhoneNumber =
            phoneNumber.substring(2 + plusDifference, phoneNumber.length);
      }
      formattedPhoneNumber += '(' +
          remainingPhoneNumber.substring(0, 3) +
          ') ' +
          remainingPhoneNumber.substring(3, 6) +
          '-' +
          remainingPhoneNumber.substring(6, remainingPhoneNumber.length);

      return formattedPhoneNumber;
    }
    return phoneNumber;
  }
}
