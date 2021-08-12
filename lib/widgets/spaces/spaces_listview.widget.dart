import 'package:flutter/material.dart';

import 'package:demos_app/widgets/spaces/spaces_slider.widget.dart';
import 'package:demos_app/modules/spaces/models/space.dart';

class SpacesListView extends StatelessWidget {
  final List<Space> spaces;
  final List<Space> invitations;

  const SpacesListView(
      {Key? key, required this.spaces, required this.invitations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          invitations.length > 0 ? _invitationsListView(size) : Container(),
          _spacesListView()
        ],
      ),
    );
  }

  Widget _invitationsListView(Size size) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 10), child: Text('INVITACIONES')),
          Divider(
            thickness: 1,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height * 0.28),
            child: SpacesSlider(spaces: invitations),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      );

  Widget _spacesListView() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 10), child: Text('TUS ESPACIOS')),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: SpacesSlider(spaces: spaces),
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      );
}
