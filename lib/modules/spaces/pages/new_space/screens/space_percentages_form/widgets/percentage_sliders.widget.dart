import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/general/slider_common_theme.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class PercentageSliders extends StatefulWidget {
  final int initialValue;
  final void Function(int) onChange;
  final String sliderTitle;
  final String sliderSubtitle;

  const PercentageSliders(
      {Key? key,
      required this.onChange,
      this.initialValue = 51,
      required this.sliderTitle,
      required this.sliderSubtitle})
      : super(key: key);

  @override
  _PercentageSlidersState createState() => _PercentageSlidersState();
}

class _PercentageSlidersState extends State<PercentageSliders> {
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
          contentPadding: EdgeInsets.all(0),
          title: Text(
            widget.sliderTitle,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            widget.sliderSubtitle,
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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
        SafeWidgetValidator(
          validators: [IsCurrentUserAdminWidgetValidator()],
          child: SliderCommonTheme(
              child: Slider(
            min: _minimumPercentage,
            max: 100,
            divisions: 100,
            value: _currentSliderValue,
            onChanged: (participationPercentage) {
              widget.onChange(participationPercentage.toInt());
              setState(() {
                _currentSliderValue = participationPercentage;
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
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' se necesitan'),
              TextSpan(
                  text: ' ${getTotalUsersCount()} usuarios',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: ' para aprobar una de las opciones de la propuesta.'),
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
