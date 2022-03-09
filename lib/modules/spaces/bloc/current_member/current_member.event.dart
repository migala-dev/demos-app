import 'package:demos_app/modules/spaces/models/member_view.model.dart';

abstract class CurrentMemberEvent {}

class SetCurrentMemberEvent extends CurrentMemberEvent {
  MemberView memberView;

  SetCurrentMemberEvent(this.memberView);
}
