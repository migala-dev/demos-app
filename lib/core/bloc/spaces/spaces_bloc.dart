import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/services/spaces.service.dart';
import 'package:equatable/equatable.dart';

part 'spaces_event.dart';
part 'spaces_state.dart';

class SpacesBloc extends Bloc<SpacesEvent, SpacesState> {
  static final _spacesBloc = SpacesBloc._internal();
  SpacesBloc._internal() : super(SpacesState(invitations: [], spaces: []));
  factory SpacesBloc() => _spacesBloc;

  @override
  Stream<SpacesState> mapEventToState(
    SpacesEvent event,
  ) async* {
    if (event is InitSpaces) {
      yield await _mapSpacesInitializeToSate();
    } else if (event is SpacesAddSpaceInvitation) {
      yield state
          .copyWith(invitations: [event.invitation, ...state.invitations]);
    }
  }

  Future<SpacesState> _mapSpacesInitializeToSate() async {
    final spaceService = SpaceService();

    final spacesStored = await spaceService.getSpaces();
    final invitationsStored = await spaceService.getInvitations();

    return SpacesState(spaces: spacesStored, invitations: invitationsStored);
  }
}
