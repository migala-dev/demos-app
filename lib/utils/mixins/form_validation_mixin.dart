mixin LoginInputValidationMixin {
  bool isNumberValid(String number) {
    final String phoneRegex = r"^[0-9]{10}$";

    return RegExp(phoneRegex).hasMatch(number);
  }

  bool isSecurityCodeValid(String code) {
    if (code.length == 6) {
      return true;
    }
    // TODO:? llamada a la api de validacion por sms

    return false;
  }
}

mixin CreateSpaceInputValidation {
  bool isSpaceNameValid(String name) => name.length > 0 && name.length < 20;
  bool isSpaceDescriptionValid(String spaceName) =>
      spaceName.length > 0 && spaceName.length <= 120;
}
