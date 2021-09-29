import 'package:demos_app/widgets/general/slider_common_theme.widget.dart';
import 'package:flutter/material.dart';

class ParticipationPercentageSlider extends StatefulWidget {
  final int initialValue;
  final void Function(int) onChange;

  const ParticipationPercentageSlider(
      {Key? key, required this.onChange, this.initialValue = 51})
      : super(key: key);

  @override
  _ParticipationPercentageState createState() =>
      _ParticipationPercentageState();
}

class _ParticipationPercentageState
    extends State<ParticipationPercentageSlider> {
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
            'Porcentaje de participación',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            'En votaciones con opción multiple',
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
        SliderCommonTheme(
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
