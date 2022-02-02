import 'package:demos_app/modules/spaces/models/member.view.dart';

abstract class CurrentMemberEvent {}

class SetCurrentMemberEvent extends CurrentMemberEvent {
  MemberView memberView;

  SetCurrentMemberEvent(this.memberView);
}
