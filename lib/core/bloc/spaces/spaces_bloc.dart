import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/spaces.service.dart';
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
      if(event == LoadSpacesEvent()) {
        yield await _mapSpacesInitializeToState();
      }
  }

  Future<SpacesState> _mapSpacesInitializeToState() async {
    final spaceService = SpaceService();

    final spacesStored = await spaceService.getSpaces();
    final invitationsStored = await spaceService.getInvitations();

    return SpacesState(spaces: spacesStored, invitations: invitationsStored);
  }
}
