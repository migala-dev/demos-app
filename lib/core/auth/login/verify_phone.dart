import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:demos_app/widgets/buttons/bigbutton_widget.dart';

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
  final TextEditingController _pinPutController = TextEditingController();

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
              fieldsCount: 5,
              onSubmit: (String pin) {
                print(pin);
                // Hide keyboard
                FocusScope.of(context).unfocus();
              },
              controller: _pinPutController,
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
            Text(
              'Reenviar mensaje de verificacion    4:36',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        BigButton(text: 'VERIFICAR', onPressed: () {})
      ],
    );
  }
}
