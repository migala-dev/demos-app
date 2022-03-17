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
