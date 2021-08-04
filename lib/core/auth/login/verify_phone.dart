import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:demos_app/utils/ui/ui_utils.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/utils/services/auth_service.dart';
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
          Navigator.pop(context);
        },
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            Text('Verifica tu número de teléfono',
                style: TextStyle(fontSize: 42)),
            SizedBox(
              height: 100,
            ),
            Expanded(child: SecurityCodeForm())
          ],
        ),
      ),
    );
  }
}

class SecurityCodeForm extends StatefulWidget {
  const SecurityCodeForm({
    Key? key,
  }) : super(key: key);

  @override
  _SecurityCodeFormState createState() => _SecurityCodeFormState();
}

class _SecurityCodeFormState extends State<SecurityCodeForm> {
  final TextEditingController _verifyCodeController = TextEditingController();
  bool _isLoading = false;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.circular(15.0),
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
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.black.withOpacity(0.5), width: 2.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TimerTextButton(
              text: 'Reenviar mensaje de verificacion',
              onPressed: verifyCode,
              duration: Duration(minutes: 4, seconds: 30),
            ),
          ],
        ),
        BigButton(
            isLoading: _isLoading, text: 'VERIFICAR', onPressed: verifyCode)
      ],
    );
  }

  void verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    final code = _verifyCodeController.text;
    final isValidCode = await AuthService().verifyCode(code);
    if (isValidCode) {
      Navigator.pushReplacementNamed(context, 'profile');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
