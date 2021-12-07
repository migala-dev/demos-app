import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/services/general_spaces.service.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';

class SpaceHandler extends EventHandlerMixin {
  static final _spaceHandler = SpaceHandler._internal();
  SpaceHandler._internal();
  factory SpaceHandler() => _spaceHandler;

  @override
  String get key => 'space';
  @override
  final List<EventHandler> eventHandlers = [SpaceUpdatedEvent()];
}

class SpaceUpdatedEvent implements EventHandler {
  @override
  String key = 'updated';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];

    await GeneralSpaceService().updateSpace(spaceId);

    SpacesBloc().add(LoadSpacesEvent());
    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }
}
