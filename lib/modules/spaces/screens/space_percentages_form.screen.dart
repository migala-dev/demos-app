import 'package:demos_app/modules/spaces/widgets/participation_percentage_slider.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/widgets/pass_rate_slider.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class SpacePercentagesFormScreen extends StatefulWidget {
  final void Function(int, int) createNewSpace;

  const SpacePercentagesFormScreen({Key? key, required this.createNewSpace})
      : super(key: key);

  @override
  _SpacePercentagesFormScreenState createState() =>
      _SpacePercentagesFormScreenState();
}

class _SpacePercentagesFormScreenState
    extends State<SpacePercentagesFormScreen> {
  int approvalPercentage = 70;
  int participationPercentage = 70;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onChange: (participationPercentage) {
              setState(() {
                this.participationPercentage = participationPercentage;
              });
            },
          ),
          Spacer(),
          BigButton(
              text: 'Crear',
              onPressed: () {
                widget.createNewSpace(
                    approvalPercentage, participationPercentage);
              })
        ],
      ),
    );
  }
}
