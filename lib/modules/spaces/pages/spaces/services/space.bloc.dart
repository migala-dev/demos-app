import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SpaceEvent {
  String spaceId;

  SpaceEvent(this.spaceId);
}

class SetSpaceEvent extends SpaceEvent {
  SetSpaceEvent(String spaceId) : super(spaceId);
}

class UpdateSpaceEvent extends SpaceEvent {
  UpdateSpaceEvent(String spaceId) : super(spaceId);
}

class SpaceBloc extends Bloc<SpaceEvent, Space?> {
  static final SpaceBloc _spaceBloc = SpaceBloc._internal();

  factory SpaceBloc() {
    return _spaceBloc;
  }

  SpaceBloc._internal() : super(null) {
    on<SetSpaceEvent>((event, emit) async {
      String spaceId = event.spaceId;
      await set(spaceId, emit);
    });
    on<UpdateSpaceEvent>((event, emit) async {
      String spaceId = event.spaceId;

      if (state != null && state!.spaceId == spaceId) {
        await set(spaceId, emit);
      }
    });
  }

  Future<void> set(String spaceId, Emitter<Space?> emit) async {
    Space? space = await SpacesRepository().findById(spaceId);
    emit(space);
  }
}
