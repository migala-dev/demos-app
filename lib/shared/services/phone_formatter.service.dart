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
            phoneNumber.substring(0, 2 + plusDifference) + " ";
        remainingPhoneNumber =
            phoneNumber.substring(2 + plusDifference, phoneNumber.length);
      }
      formattedPhoneNumber += "(" +
          remainingPhoneNumber.substring(0, 3) +
          ") " +
          remainingPhoneNumber.substring(3, 6) +
          "-" +
          remainingPhoneNumber.substring(6, remainingPhoneNumber.length);

      return formattedPhoneNumber;
    }
    return phoneNumber;
  }
}
