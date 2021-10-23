import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';

void reloadSpaceList() {
    final spacesBloc = SpacesBloc();
    spacesBloc.add(LoadSpacesEvent());
  }