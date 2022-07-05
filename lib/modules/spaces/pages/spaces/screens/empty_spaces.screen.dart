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

import 'package:demos_app/config/custom-icons/demos_icons_icons.dart';
import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/pages/spaces/widgets/popup_spaces_menu_options.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class EmptySpacesScreen extends StatelessWidget {
  const EmptySpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: const Text('Demos'),
          actions: [PopupSpacesMenuOptions()],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.05, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 28.0),
                        child: Icon(
                          DemosIcons.empty_space_outlined,
                          color: primaryColorLight,
                          size: size.width * 0.3,
                        ),
                      ),
                      Text('No tienes espacios por el momento',
                          style: TextStyle(
                              color: primaryColorLight, fontSize: 16.0)),
                    ],
                  ),
                ),
                SafeWidgetValidator(
                    child: BigButton(
                  onPressed: () => goToCreateNewSpace(context),
                  text: 'Crea tu primer espacio',
                ))
              ],
            ),
          ),
        ));
  }

  void goToCreateNewSpace(BuildContext context) {
    Navigator.pushNamed(context, Routes.newSpace);
  }
}
