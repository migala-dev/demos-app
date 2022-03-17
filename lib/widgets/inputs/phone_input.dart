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

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final bool disabled;

  const PhoneInput({Key? key, required this.controller, this.disabled = false})
      : super(key: key);
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final countries = [
    'MX',
    'AR',
    'BO',
    'BR',
    'CL',
    'EC',
    'PE',
    'US',
    'CO',
    'PY',
    'UY',
    'VE'
  ];

  _PhoneInputState();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      countries: countries,
      enabled: !widget.disabled,
      searchText: 'Buscar por nombre de país',
      autoValidate: false,
      validator: validatePhone,
      decoration: const InputDecoration(
        labelText: 'Número Teléfonico',
      ),
      initialCountryCode: 'MX',
      onChanged: (phone) {
        widget.controller.text = phone.completeNumber;
      },
    );
  }

  String? validatePhone(String? phoneNumber) {
    return isPhoneNumberValid(phoneNumber)
        ? null
        : 'Número Teléfonico invalido.';
  }

  bool isPhoneNumberValid(String? phoneNumber) {
    if (phoneNumber == null) {
      return false;
    }

    const String phoneRegex =
        r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';

    RegExp regExp = RegExp(phoneRegex);

    return regExp.hasMatch(phoneNumber);
  }
}
