import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';

void reloadSpaceList() {
    SpacesBloc().add(LoadSpacesEvent());
}