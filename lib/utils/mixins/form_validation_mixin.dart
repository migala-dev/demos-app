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
