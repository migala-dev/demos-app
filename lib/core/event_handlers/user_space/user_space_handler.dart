import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/data_event.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

class UserSpaceHandler extends EventHandlerMixin {
  static final _userSpaceHandler = UserSpaceHandler._internal();
  UserSpaceHandler._internal();
  factory UserSpaceHandler() => _userSpaceHandler;

  @override
  String key = 'user_space';
  @override
  final List<EventHandler> eventHandlers = [UserSpaceInvitationEvent()];
}

class UserSpaceInvitationEvent implements EventHandler {
  @override
  String key = 'invitation';

  @override
  Future<void> handleEvent(DataEvent dataEvent) async {
    final newInvitationSpace = SpaceView.fromObject(dataEvent.data!);

    final spacesBloc = SpacesBloc();
    spacesBloc.add(SpacesAddSpaceInvitation(newInvitationSpace));
  }
}
