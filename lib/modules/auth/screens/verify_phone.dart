import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/auth/services/auth.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:demos_app/utils/ui/ui_utils.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/timer_text_button_widget.dart';

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          goToLogin(context);
        },
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            Text('Verifica tu número teléfono', style: TextStyle(fontSize: 42)),
            SizedBox(
              height: 100,
            ),
            Expanded(child: SecurityCodeForm())
          ],
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (r) => false);
  }
}

class SecurityCodeForm extends StatefulWidget {
  const SecurityCodeForm({
    Key? key,
  }) : super(key: key);

  @override
  _SecurityCodeFormState createState() => _SecurityCodeFormState();
}

class _SecurityCodeFormState extends State<SecurityCodeForm>
    with LoadingStateHandler {
  final TextEditingController _verifyCodeController = TextEditingController();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black, width: 4.0)),
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
            Text(
              'Código de seguridad',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            PinPut(
              fieldsCount: 6,
              onSubmit: (String pin) {
                hideKeyboard(context);
              },
              controller: _verifyCodeController,
              textStyle: TextStyle(fontSize: 20.0),
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.5), width: 4.0)),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                border: Border(
                    bottom: BorderSide(color: Colors.blueAccent, width: 4.0)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TimerTextButton(
              text: 'Reenviar código de verificación',
              onPressed: (restartTimer) {
                resendCode(restartTimer);
              },
              duration: Duration(minutes: 2, seconds: 30),
              disabled: isLoading,
            ),
          ],
        ),
        BigButton(
            isLoading: isLoading, text: 'VERIFICAR', onPressed: verifyCode)
      ],
    );
  }

  void resendCode(void Function() restartTimer) async {
    wrapLoadingTransaction(() async {
      _verifyCodeController.text = '';
      bool isCodeResended = await AuthService().resendCode();
      if (isCodeResended) {
        restartTimer();
      }
    });
  }

  void verifyCode() async {
    wrapLoadingTransaction(() async {
      String code = _verifyCodeController.text;
      if (code != '') {
        try {
          User? user = await AuthService().verifyCode(code);
          if (user != null) {
            bool thisUserHasAlreadyInfo =
                user.name != "" || user.profilePictureKey != null;
            String route =
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
