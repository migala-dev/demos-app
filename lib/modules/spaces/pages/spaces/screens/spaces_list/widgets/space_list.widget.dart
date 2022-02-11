import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpaceListWidget<T extends SpaceView> extends StatelessWidget {
  final String Function(T) getSubtitle;
  final void Function(T) onSpaceTab;
  final List<T> spaces;
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
        T spaceView = spaces[index];
        return SpaceTile<T>(
            spaceView: spaceView,
            getSubtitle: getSubtitle,
            onSpaceTab: () {
              onSpaceTab(spaceView);
            });
      },
    );
  }
}
