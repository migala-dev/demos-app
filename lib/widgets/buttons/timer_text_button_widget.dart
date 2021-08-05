import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class TimerTextButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Duration duration;
  final String text;

  TimerTextButton(
      {Key? key,
      required this.onPressed,
      required this.duration,
      required this.text})
      : super(key: key);

  @override
  _TimerTextButtonState createState() =>
      _TimerTextButtonState(onPressed, duration, text);
}

class _TimerTextButtonState extends State<TimerTextButton> {
  final VoidCallback onPressed;
  final Duration duration;
  final String text;

  String _currentTimeRemaining = '';

  bool _done = false;

  StreamSubscription<CountdownTimer>? sub;

  _TimerTextButtonState(this.onPressed, this.duration, this.text);

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      duration,
      Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub?.onData((duration) {
      setState(() {
        _currentTimeRemaining = _formatDuration(duration.remaining);
      });
    });

    sub?.onDone(() {
      setState(() {
        _done = true;
        _currentTimeRemaining = '';
      });
      sub?.cancel();
    });
  }

  @override
  void initState() {
    _currentTimeRemaining = _formatDuration(duration);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds < 10 ? '0$seconds' : seconds}';
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _done ? onPressed : null,
        child: Text(
          '$text    $_currentTimeRemaining',
        ));
  }
}
