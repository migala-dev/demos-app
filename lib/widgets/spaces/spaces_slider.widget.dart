import 'package:demos_app/modules/spaces/models/space.dart';
import 'package:demos_app/widgets/spaces/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpacesSlider extends StatelessWidget {
  final List<Space> spaces;
  const SpacesSlider({Key? key, required this.spaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: spaces.length,
      itemBuilder: (context, index) => SpaceTile(
          image: Container(
            color: Colors.grey,
          ),
          name: spaces[index].name,
          members: spaces[index].members),
    );
  }
}
