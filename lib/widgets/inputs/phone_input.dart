import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final bool enabled;

  const PhoneInput({Key? key, required this.controller, this.enabled = true})
      : super(key: key);
  @override
  _PhoneInputState createState() => _PhoneInputState(controller, enabled);
}

class _PhoneInputState extends State<PhoneInput> {
  final TextEditingController controller;
  final bool enabled;

  _PhoneInputState(this.controller, this.enabled);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      countries: [
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
      ],
      enabled: enabled,
      searchText: 'Buscar por nombre de país',
      autoValidate: false,
      validator: validatePhone,
      decoration: InputDecoration(
        labelText: 'Número Teléfonico',
      ),
      initialCountryCode: 'MX',
      onChanged: (phone) {
        controller.text = phone.completeNumber;
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

    final String phoneRegex =
        r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$";

    RegExp regExp = RegExp(phoneRegex);

    return regExp.hasMatch(phoneNumber);
  }
}
