import 'package:flutter/material.dart';

class ParticipationPercentageSlider extends StatefulWidget {
  final double minimumPercentage;

  const ParticipationPercentageSlider(
      {Key? key, required this.minimumPercentage})
      : super(key: key);

  @override
  __ParticipationPercentageState createState() =>
      __ParticipationPercentageState();
}

class __ParticipationPercentageState
    extends State<ParticipationPercentageSlider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = widget.minimumPercentage;
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
            style: TextStyle(fontSize: 19),
          ),
          subtitle: Text('En votaciones con opción multiple'),
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
        Slider(
          min: 0,
          max: 100,
          divisions: 10,
          value: _currentSliderValue,
          onChanged: (v) {
            setState(() {
              if (v >= widget.minimumPercentage) {
                _currentSliderValue = v;
              }
            });
          },
        ),
        RichText(
          text: TextSpan(
            text: 'Ejemplo: Si se tiene un total de ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: '30 usuarios',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' se necesitan'),
              TextSpan(
                  text: ' ${(30 * (_currentSliderValue) ~/ 100)} usuarios',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: ' para aprovar una de las opciones de la propuesta'),
            ],
          ),
        )
      ],
    );
  }
}
