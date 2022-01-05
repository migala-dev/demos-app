import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/empty_spaces.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/loading_spaces.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/spaces_list.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/utils/checkers.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpacesBloc, SpacesState>(builder: (context, state) {
      if (state is LoadingSpaces) {
        return const LoadingSpacesScreen();
      }

      if (areSpacesEmpty(state)) {
        return const EmptySpacesScreen();
      }
      return SpaceListScreen(
          spaces: state.spaces, invitations: state.invitations);
    });
  }
}
