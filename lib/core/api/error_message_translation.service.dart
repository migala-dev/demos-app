Map<String, String> errorMessageDictonary = {
  'DefineAuthChallenge failed with error Invalid OTP.':
      'Se ha superado el número de intentos, ingrese su número de nuevo.',
  'User is not admin from this space':
      'El usuario no es administrador de este espacio.',
  'Invitation expired.': 'Invitación expirada.',
  'This invitation is not in a valid status.': 'El estado de invitación no es el correcto, pide que te la envíen nuevamente.',
};

class ErrorMessageTraslation {
  static String getMessage(String message) {
    return errorMessageDictonary[message] ?? message;
  }
}
