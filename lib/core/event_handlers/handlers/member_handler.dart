import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/models/errors/user_is_not_member.error.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/bloc/space_members_bloc.dart';
import 'package:demos_app/modules/spaces/pages/new_space/services/new_space.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/shared/services/new_invitation_dialog.service.dart';

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

    await NewSpaceService().handleSpaceInvitation(response);
    NewInvitationDialogService().open(response.space, response.member);
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
    try {
      final spaceMembersBloc = SpaceMembersBloc();
      final currerntSpaceId = SpaceBloc().state?.spaceId;
      await MemberService().getMember(spaceId, memberId);

      if (currerntSpaceId == spaceId) {
        spaceMembersBloc.add(SpaceMemberUpdated(memberId));
      }
    } catch (err) {
      if (err != UserIsNotMemberError()) {
        rethrow;
      }
    }
  }
}

class InvitationCanceledEvent implements EventHandler {
  @override
  String key = 'invitation:canceled';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String memberId = dataEvent.data!['memberId'];
    String spaceId = dataEvent.data!['spaceId'];
    final spaceMembersBloc = SpaceMembersBloc();
    final currerntSpaceId = SpaceBloc().state?.spaceId;

    await MemberService().cancelInvitation(memberId);

    SpacesBloc().add(LoadSpacesEvent());

    if (currerntSpaceId == spaceId) {
      spaceMembersBloc.add(SpaceMemberDeleted(memberId));
    }
  }
}

class MembershipRemovedEvent implements EventHandler {
  @override
  String key = 'deleted';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String memberId = dataEvent.data!['memberId'];
    String spaceId = dataEvent.data!['spaceId'];
    try {
      await MemberService().removeMembership(memberId, spaceId);

      SpacesBloc().add(LoadSpacesEvent());
    } catch (err) {
      if (err != UserIsNotMemberError()) {
        rethrow;
      }
    }
  }
}
