import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpaceListWidget extends StatelessWidget {
  final String Function(SpaceView) getSubtitle;
  final void Function(SpaceView) onSpaceTab;
  final List<SpaceView> spaces;
  const SpaceListWidget(
      {Key? key,
      required this.spaces,
      required this.onSpaceTab,
      required this.getSubtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: spaces.length,
      itemBuilder: (context, index) {
        SpaceView spaceView = spaces[index];
        return SpaceTile(
            spaceView: spaceView,
            getSubtitle: getSubtitle,
            onSpaceTab: () {
              onSpaceTab(spaceView);
            });
      },
    );
  }
}
