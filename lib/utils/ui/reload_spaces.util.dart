import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';

void reloadSpaceList() {
    SpacesBloc().add(LoadSpacesEvent());
}