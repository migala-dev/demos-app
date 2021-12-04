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
