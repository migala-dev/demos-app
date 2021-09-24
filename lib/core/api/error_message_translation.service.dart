Map<String, String> errorMessageDictonary = {
  'DefineAuthChallenge failed with error Invalid OTP.':
      'Se ha superado el número de intentos, ingrese su número de nuevo.'
};

class ErrorMessageTraslation {
  static getMessage(String message) {
    return errorMessageDictonary[message] ?? message;
  }
}
