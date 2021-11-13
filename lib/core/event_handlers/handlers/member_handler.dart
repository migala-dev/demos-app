import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';

class MemberHandler extends EventHandlerMixin {
  static final _memberHandler = MemberHandler._internal();
  MemberHandler._internal();
  factory MemberHandler() => _memberHandler;

  @override
  String key = 'member';
  @override
  final List<EventHandler> eventHandlers = [UserSpaceInvitationEvent()];
}

class UserSpaceInvitationEvent implements EventHandler {
  @override
  String key = 'invitation';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];

    SpaceResponse response = await SpaceApi().getSpace(spaceId);

    await NewSpaceService().addSpaceEntitiesFromResponse(response);

    final spacesBloc = SpacesBloc();
    spacesBloc.add(LoadSpacesEvent());
  }
}
