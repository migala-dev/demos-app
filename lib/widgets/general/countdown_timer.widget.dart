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
  String countText = '';

  @override
  void initState() {
    countText = getTimeRemaingDescription();
    if (widget.dateTime != null) {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 60), (_) => setCountDown());
    }
    super.initState();
  }

  void setCountDown() {
    setState(() {
      countText = getTimeRemaingDescription();
    });
  }

  String getTimeRemaingDescription() {
    if (widget.dateTime != null) {
      difference = widget.dateTime!.difference(DateTime.now());
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
    return Text(countText,
        style: const TextStyle(
          fontSize: 16,
        ));
  }
}
