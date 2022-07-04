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

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/auth/services/auth.service.dart';
import 'package:demos_app/shared/services/phone_formatter.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:demos_app/utils/ui/ui_utils.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/timer_text_button_widget.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage>
    with LoadingStateHandler {
  final TextEditingController _verifyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = PhoneFormatterService.format(AuthService().getPhoneNumber());
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            goToLogin(context);
          },
        )),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: CardWidget(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 50),
                                Text('Verifica tu número teléfono',
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 20),
                                const Text(
                                  'Mensaje enviado al',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(phoneNumber, 
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600)),
                                const SizedBox(height: 75),
                                Expanded(
                                    child: SecurityCodeForm(
                                  verifyCodeController: _verifyCodeController,
                                  isLoading: isLoading,
                                  verifyCode: () {
                                    verifyCode();
                                  },
                                  resendCode: (restartTimer) {
                                    resendCode(restartTimer);
                                  },
                                ))
                              ],
                            ),
                          ),
                        ))),
                BigButton(isLoading: isLoading, text: 'VERIFICAR', onPressed: () {
                  verifyCode();
                })
              ],
            )));
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (r) => false);
  }

  void resendCode(void Function() restartTimer) async {
    wrapLoadingTransaction(() async {
      _verifyCodeController.text = '';
      final bool isCodeResended = await AuthService().resendCode();
      if (isCodeResended) {
        restartTimer();
      }
    });
  }

  void verifyCode() async {
    wrapLoadingTransaction(() async {
      final String code = _verifyCodeController.text;
      if (code != '') {
        try {
          final User? user = await AuthService().verifyCode(code);
          if (user != null) {
            final bool thisUserHasAlreadyInfo =
                user.name != '' || user.profilePictureKey != null;
            final String route =
                thisUserHasAlreadyInfo ? Routes.spaces : Routes.initialProfile;
            Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
          }
        } catch (err) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (r) => false);
        }
      }
    });
  }
}

class SecurityCodeForm extends StatefulWidget {
  final TextEditingController verifyCodeController;
  final bool isLoading;
  final VoidCallback verifyCode;
  final Function(VoidCallback restartTimer) resendCode;

  const SecurityCodeForm(
      {Key? key,
      required this.verifyCodeController,
      required this.isLoading,
      required this.verifyCode,
      required this.resendCode})
      : super(key: key);

  @override
  _SecurityCodeFormState createState() => _SecurityCodeFormState();
}

class _SecurityCodeFormState extends State<SecurityCodeForm> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: primaryColorDark, width: 4.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Código de seguridad',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            PinPut(
              fieldsCount: 6,
              onSubmit: (String pin) {
                widget.verifyCode();
                hideKeyboard(context);
              },
              controller: widget.verifyCodeController,
              textStyle: const TextStyle(fontSize: 20.0),
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                border: Border(
                    bottom: BorderSide(
                        color: primaryColorLight, width: 4.0)),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                border: Border(
                    bottom: BorderSide(color: primaryColor, width: 4.0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TimerTextButton(
              text: 'Reenviar código de verificación',
              onPressed: (restartTimer) {
                widget.resendCode(restartTimer);
              },
              duration: const Duration(minutes: 2, seconds: 30),
              disabled: widget.isLoading,
            ),
          ],
        ),
      ],
    );
  }
}
