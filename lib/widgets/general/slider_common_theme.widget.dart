import 'package:flutter/material.dart';

import 'custom_track_shape.widget.dart';

class SliderCommonTheme extends StatelessWidget {
  final Widget child;

  const SliderCommonTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          trackShape: CustomTrackShape(),
          thumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
          trackHeight: 5.0),
      child: child,
    );
  }
}
