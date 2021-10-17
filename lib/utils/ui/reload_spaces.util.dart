import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';

void reloadSpaceListk() {
    final spacesBloc = SpacesBloc();
    spacesBloc.add(LoadSpacesEvent());
  }