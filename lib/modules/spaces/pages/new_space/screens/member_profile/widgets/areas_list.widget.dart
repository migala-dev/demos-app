import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/widgets/area_chip.widget.dart';
import 'package:flutter/material.dart';

class AreasList extends StatelessWidget {
  const AreasList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        AreaChip(color: Colors.purple, text: 'App', borderRadiusSize: 5),
        AreaChip(color: Colors.red, text: 'Blockchain', borderRadiusSize: 5),
        AreaChip(color: Colors.green, text: 'Token', borderRadiusSize: 5),
      ],
    );
  }
}
