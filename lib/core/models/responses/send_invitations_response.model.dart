import '../member.model.dart';

class SendInvitationsResponse {
  late List<Member> _members;
  
  List<Member> get members => this._members;
  
  SendInvitationsResponse.fromObject(dynamic list) {
    List<dynamic> membersResponse = list;
    this._members = membersResponse.map((s) => Member.fromObject(s)).toList();
  }
}