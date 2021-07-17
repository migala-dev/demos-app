import 'package:flutter/material.dart';

import 'package:demos_app/utils/mixins/form_validation_mixin.dart';
import 'package:demos_app/widgets/buttons/bigbutton_widget.dart';
import 'package:demos_app/widgets/simbols/demos_logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          DemosLogo(),
          SizedBox(
            height: 35,
          ),
          InputPhoneNumber()
        ],
      ),
    );
  }
}

class InputPhoneNumber extends StatefulWidget {
  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber>
    with LoginFormValidationsMixin {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Número Teléfonico'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      )),
                  keyboardType: TextInputType.number,
                  validator: (String? number) =>
                      isNumberValid(number) ? null : 'Número no valido.',
                ),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          print('info');
                        },
                        child: Text('Para mas informacion hacer click aqui'))
                  ],
                ),
                Spacer(),
                BigButton(
                    text: 'SIGUIENTE',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, 'verifyPhone');
                        print('Número valido');
                      }
                    }),
              ],
            )),
      ),
    );
  }
}
