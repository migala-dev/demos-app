import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/widgets/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpacesScrollView extends StatelessWidget {
  final List<SpaceView> spaces;
  const SpacesScrollView({Key? key, required this.spaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: spaces.length,
      itemBuilder: (context, index) {
        SpaceView space = spaces[index];
        return SpaceTile(space: space);
      },
    );
  }
}
