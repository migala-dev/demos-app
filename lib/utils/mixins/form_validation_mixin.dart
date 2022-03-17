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

mixin LoginFormValidationsMixin {
  bool isNumberValid(String? number) {
    if (number == null) {
      return false;
    }

    const String phoneRegex = r'^[0-9]{10}$';

    return RegExp(phoneRegex).hasMatch(number);
  }

  bool isSecurityCodeValid(String code) {
    if (code.length == 6) {
      return true;
    }

    return false;
  }
}

mixin SpaceFormValidationsMixin {
  bool isSpaceNameValid(String name) => name.isNotEmpty && name.length < 20;
  bool isSpaceDescriptionValid(String spaceName) =>
      spaceName.isNotEmpty && spaceName.length <= 120;
}
