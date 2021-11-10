import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/widgets/approval_percentage_slider.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/space_percentages_form/widgets/participation_percentage_slider.widget.dart';
import 'package:demos_app/utils/ui/global_colors.util.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class SpacePercentagesFormScreen extends StatefulWidget {
  final void Function(int, int) createNewSpace;
  final bool isLoading;

  const SpacePercentagesFormScreen(
      {Key? key, required this.createNewSpace, this.isLoading = false})
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
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        children: [
          ApprovalPercentageSlider(
            initialValue: approvalPercentage,
            onChange: (approvalPercentage) {
              setState(() {
                this.approvalPercentage = approvalPercentage;
              });
            },
          ),
          Container(
            height: 30.0,
            margin: EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: greyColor))),
          ),
          ParticipationPercentageSlider(
            initialValue: participationPercentage,
            onChange: (participationPercentage) {
              setState(() {
                this.participationPercentage = participationPercentage;
              });
            },
          ),
          Spacer(),
          Text("* Estos porcentages podrán ser actualizados dentro del espacio.",
              style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 16),
          BigButton(
              text: 'Crear',
              isLoading: widget.isLoading,
              onPressed: () {
                widget.createNewSpace(
                    approvalPercentage, participationPercentage);
              })
        ],
      ),
    );
  }
}
