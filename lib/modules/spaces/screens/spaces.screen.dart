import 'package:demos_app/modules/spaces/screens/empty_spaces.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demos_app/modules/spaces/screens/spaces_list.screen.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  bool areSpacesEmpty(SpacesState state) =>
      state.spaces.length == 0 && state.invitations.length == 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpacesBloc, SpacesState>(builder: (context, state) {
      if (areSpacesEmpty(state)) {
        return EmptySpacesScreen();
      }

      return SpaceListScreen(
          spaces: state.spaces, invitations: state.invitations);
    });
  }
}
