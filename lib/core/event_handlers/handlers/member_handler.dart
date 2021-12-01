import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';

class MemberHandler extends EventHandlerMixin {
  static final _memberHandler = MemberHandler._internal();
  MemberHandler._internal();
  factory MemberHandler() => _memberHandler;

  @override
  String get key => 'members';
  @override
  final List<EventHandler> eventHandlers = [
    SpaceInvitationEvent(),
    UpdateMemberEvent(),
    InvitationCanceledEvent(),
    MembershipRemovedEvent()
  ];
}

class SpaceInvitationEvent implements EventHandler {
  @override
  String key = 'invitation';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];

    SpaceResponse response = await SpaceApi().getSpace(spaceId);

    await NewSpaceService().addSpaceEntitiesFromResponse(response);

    SpacesBloc().add(LoadSpacesEvent());
  }
}

class UpdateMemberEvent implements EventHandler {
  @override
  String key = 'updated';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];
    String memberId = dataEvent.data!['memberId'];

    MemberService().getMember(spaceId, memberId);
  }
}

class InvitationCanceledEvent implements EventHandler {
  @override
  String key = 'invitation:canceled';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String memberId = dataEvent.data!['memberId'];

    await MemberService().cancelInvitation(memberId);

    SpacesBloc().add(LoadSpacesEvent());
  }
}

class MembershipRemovedEvent implements EventHandler {
  @override
  String key = 'deleted';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String memberId = dataEvent.data!['memberId'];
    String spaceId = dataEvent.data!['spaceId'];

    await MemberService().removeMembership(memberId, spaceId);

    SpacesBloc().add(LoadSpacesEvent());
  }
}
