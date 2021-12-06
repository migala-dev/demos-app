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
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            widget.subtitle,
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Container(
            alignment: Alignment.center,
            height: 40,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              '${_currentSliderValue.toInt()} %',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
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
    );
  }

  int getTotalUsersCount() {
    return (_exampleTotalUsers * (_currentSliderValue / 100)).ceil();
  }
}
