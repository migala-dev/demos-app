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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/widgets/general/card.widget.dart';
import 'package:demos_app/widgets/general/slider_common_theme.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';
import 'package:flutter/material.dart';

class SpacePercentage extends StatefulWidget {
  final int initialValue;
  final void Function(int) onChange;
  final String title;
  final String subtitle;
  final String toBeApprovedLabel;
  final List<WidgetValidator>? validators;

  const SpacePercentage({
    Key? key,
    required this.onChange,
    this.initialValue = 51,
    required this.title,
    required this.subtitle,
    required this.toBeApprovedLabel,
    this.validators,
  }) : super(key: key);

  @override
  _SpacePercentageState createState() => _SpacePercentageState();
}

class _SpacePercentageState extends State<SpacePercentage> {
  final double _minimumPercentage = 51;
  final int _exampleTotalUsers = 30;
  double _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = widget.initialValue.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        child: Container(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 32.0, right: 24.0,  left: 24.0),
            child: Column(
              children: [
                ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500, color: primaryColor),
                    ),
                    subtitle: Text(
                      widget.subtitle,
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      '${_currentSliderValue.toInt()} %',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18, color: primaryColor),
                    )),
                SafeWidgetValidator(
                  validators: widget.validators,
                  child: SliderCommonTheme(
                      child: Slider(
                    min: _minimumPercentage,
                    max: 100,
                    divisions: 100,
                    value: _currentSliderValue,
                    onChanged: (percentage) {
                      widget.onChange(percentage.toInt());
                      setState(() {
                        _currentSliderValue = percentage;
                      });
                    },
                  )),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ejemplo: Si se tiene un total de ',
                    style: DefaultTextStyle.of(context).style.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: '$_exampleTotalUsers usuarios',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' se necesitan'),
                      TextSpan(
                          text: ' ${getTotalUsersCount()} usuarios',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: widget.toBeApprovedLabel),
                    ],
                  ),
                )
              ],
            )));
  }

  int getTotalUsersCount() {
    return (_exampleTotalUsers * (_currentSliderValue / 100)).ceil();
  }
}
