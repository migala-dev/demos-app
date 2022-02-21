import 'package:demos_app/modules/spaces/models/space_view.model.dart';

abstract class SpaceEvent {

  SpaceEvent();
}

class SetSpaceIdEvent extends SpaceEvent {
  final String spaceId;

  SetSpaceIdEvent(this.spaceId) : super();
}

class UpdateSpaceEvent extends SpaceEvent {
  final String spaceId;

  UpdateSpaceEvent(this.spaceId) : super();
}

class SetSpaceViewEvent extends SpaceEvent {
  final SpaceView spaceView;

  SetSpaceViewEvent(this.spaceView) : super();
}