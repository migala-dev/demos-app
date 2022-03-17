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

import 'package:demos_app/widgets/simbols/version_and_build_number.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/auth/services/auth.service.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/ui_utils.dart';
import 'package:demos_app/widgets/inputs/phone_input.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/simbols/demos_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    child: Column(
                      children: [
                        Container(
                          child: const DemosLogo(),
                          margin: EdgeInsets.only(
                              top: size.height * 0.1, bottom: 35.0),
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(bottom: 40.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [VersionAndBuildNumber()],
                        ),
                        const SizedBox(height: 10),
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
