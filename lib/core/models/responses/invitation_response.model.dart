import '../member.model.dart';

class InvitationResponse {
  late Member _member;

  Member get member => _member;

  InvitationResponse.fromObject(dynamic o) {
    _member = Member.fromObject(o['member']);
  }
}
