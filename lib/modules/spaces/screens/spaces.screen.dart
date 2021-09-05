import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/screens/spaces_list.screen.dart';
import 'package:demos_app/modules/spaces/services/spaces.service.dart';
import 'package:flutter/material.dart';

import 'empty_spaces.screen.dart';

class SpacesScreen extends StatefulWidget {
  SpacesScreen({Key? key}) : super(key: key);

  @override
  _SpacesScreenState createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  List<SpaceView> spaces = [];
  List<SpaceView> invitations = [];

  _SpacesScreenState() {
    initializeSpaces();
    initializeInvitations();
  }

  Future<void> initializeSpaces() async {
    final spacesStored = await SpaceService().getSpaces();
    setState(() {
      spaces = spacesStored;
    });
  }

  Future<void> initializeInvitations() async {
    final invitationsStored = await SpaceService().getInvitations();
    setState(() {
      invitations = invitationsStored;
    });
  }

  bool areSpacesEmpty() => spaces.length == 0 && invitations.length == 0;

  @override
  Widget build(BuildContext context) {
    if (areSpacesEmpty()) {
      return EmptySpacesScreen();
    }
    return SpaceListScreen(spaces: spaces, invitations: invitations);
  }
}
