import 'package:demos_app/modules/spaces/models/space.model.dart';
import 'package:demos_app/modules/spaces/widgets/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpacesScrollView extends StatelessWidget {
  final List<Space> spaces;
  const SpacesScrollView({Key? key, required this.spaces}) : super(key: key);

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
