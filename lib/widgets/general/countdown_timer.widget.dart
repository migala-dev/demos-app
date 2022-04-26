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
