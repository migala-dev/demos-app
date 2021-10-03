import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/spaces.service.dart';
import 'package:equatable/equatable.dart';

part 'spaces_event.dart';
part 'spaces_state.dart';

class SpacesBloc extends Bloc<SpacesEvent, SpacesState> {
  static final _spacesBloc = SpacesBloc._internal();
  SpacesBloc._internal() : super(SpacesState(invitations: [], spaces: [])) {
    on<LoadSpacesEvent>(_onLoadSpaces);
  }
  factory SpacesBloc() => _spacesBloc;

  FutureOr<void> _onLoadSpaces(
      SpacesEvent event, Emitter<SpacesState> emit) async {
    final spaceService = SpaceService();

    final spacesStored = await spaceService.getSpaces();
    final invitationsStored = await spaceService.getInvitations();

    emit(SpacesState(spaces: spacesStored, invitations: invitationsStored));
  }
}
