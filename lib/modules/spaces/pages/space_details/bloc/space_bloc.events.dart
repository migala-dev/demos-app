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