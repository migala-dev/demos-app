import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class TimerTextButton extends StatefulWidget {
  final void Function(void Function()) onPressed;
  final Duration duration;
  final String text;
  final bool disabled;

  const TimerTextButton(
      {Key? key,
      required this.onPressed,
      required this.duration,
      required this.text,
      this.disabled = false})
      : super(key: key);

  @override
  _TimerTextButtonState createState() => _TimerTextButtonState();
}

class _TimerTextButtonState extends State<TimerTextButton> {
  String _currentTimeRemaining = '';

  bool _done = false;

  StreamSubscription<CountdownTimer>? sub;

  _TimerTextButtonState();

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      widget.duration,
      const Duration(seconds: 1),
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
    start();
    super.initState();
  }

  void start() {
    _done = false;
    _currentTimeRemaining = _formatDuration(widget.duration);
    startTimer();
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
    return _done ? getLink() : getTimer();
  }

  Widget getTimer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(widget.text), Text(_currentTimeRemaining)],
      ),
    );
  }

  Widget getLink() {
    return TextButton(
        onPressed: widget.disabled ? null : onActionPressed,
        child: Text(widget.text));
  }

  void onActionPressed() {
    if (_done) {
      widget.onPressed(() => start());
    }
  }
}
