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

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime? dateTime;

  const CountdownTimer({Key? key, this.dateTime}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration? difference;

  @override
  void initState() {
    difference = widget.dateTime!.difference(DateTime.now());
    if (widget.dateTime != null) {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 30), (_) => setCountDown());
    }
    super.initState();
  }

  void setCountDown() {
    if (!mounted) return;
    setState(() {
      difference = widget.dateTime!.difference(DateTime.now());
    });
  }

  String getTimeRemaingDescription() {
    if (widget.dateTime != null) {
      if (difference!.inMinutes > 0) {
        String differenceInHours = difference!.inHours.toString();
        String differenceInMinutes = (difference!.inMinutes % 60).toString();
        String hoursLabel = difference!.inHours > 1 ? 'horas' : 'hora';

        if (difference!.inHours == 0) {
          return '$differenceInMinutes minutos';
        }
        return '$differenceInHours $hoursLabel y $differenceInMinutes minutos';
      }
      return 'Expirado';
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    String countText = getTimeRemaingDescription();
    return Text(countText,
        style: const TextStyle(
          fontSize: 16,
        ));
  }
}
