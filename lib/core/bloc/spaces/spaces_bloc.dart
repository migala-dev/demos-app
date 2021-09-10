import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/models/space.model.dart';
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
    if (event is SpacesAddSpaceInvitation) {
      yield state
          .copyWith(invitations: [event.invitation, ...state.invitations]);
    }
  }
}
