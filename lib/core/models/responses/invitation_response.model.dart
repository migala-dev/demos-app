
import '../member.dart';

class InvitationResponse {
  late Member _member;
  
  Member get member => this._member;
  
  InvitationResponse.fromObject(dynamic o) {
    this._member = Member.fromObject(o["member"]);
  }
}