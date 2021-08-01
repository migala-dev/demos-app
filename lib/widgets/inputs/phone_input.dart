import 'package:flutter/material.dart';

class PhoneInput extends StatefulWidget {
  final _phoneNumberKey;

  PhoneInput(this._phoneNumberKey);

  @override
  _PhoneInputState createState() => _PhoneInputState(_phoneNumberKey);
}

class _PhoneInputState extends State<PhoneInput> {
  final _phoneNumberKey;

  _PhoneInputState(this._phoneNumberKey);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _phoneNumberKey,
      decoration: InputDecoration(
          labelText: 'Número Teléfonico', hintText: '+52646364634'),
      validator: validatePhone,
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

    /*  final String phoneRegex =
        r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"; */

    return true;
  }
}
