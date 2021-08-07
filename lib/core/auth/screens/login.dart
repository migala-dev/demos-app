import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/utils/ui/ui_utils.dart';
import 'package:demos_app/core/auth/services/auth_service.dart';
import 'package:demos_app/widgets/inputs/phone_input.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/simbols/demos_logo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoadingStateHandler {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
                child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Column(
                      children: [
                        Container(
                          child: DemosLogo(),
                          margin: EdgeInsets.only(
                              top: size.height * 0.1, bottom: 35.0),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(bottom: 40.0),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  PhoneInput(
                                    controller: _phoneNumberController,
                                    disabled: isLoading,
                                  )
                                ],
                              )),
                        )),
                        BigButton(
                            isLoading: isLoading,
                            text: 'SIGUIENTE',
                            onPressed: () => verifyPhone(context)),
                      ],
                    ))),
          ),
        );
      },
    ));
  }

  void verifyPhone(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      wrapLoadingTransaction(() async {
        hideKeyboard(context);
        String phoneNumber = _phoneNumberController.value.text;
        bool itSignInSuccessfully = await AuthService().signIn(phoneNumber);
        if (itSignInSuccessfully) {
          Navigator.pushNamed(context, Routes.verifyPhone);
        }
      });
    }
  }
}
