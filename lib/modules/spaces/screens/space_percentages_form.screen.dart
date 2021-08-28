import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/widgets/participation_percentage_slider.widget.dart';
import 'package:demos_app/modules/spaces/widgets/pass_rate_slider.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class SpacePercentagesFormScreen extends StatelessWidget {
  const SpacePercentagesFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          children: [
            PassRateSlider(
              minimumPercentage: 70,
            ),
            SizedBox(
              height: 30,
            ),
            ParticipationPercentageSlider(
              minimumPercentage: 70,
            ),
            Spacer(),
            BigButton(text: 'Crear', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Column _appBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Crear Espacio'),
        Text(
          'Paso 2 de 2',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}
