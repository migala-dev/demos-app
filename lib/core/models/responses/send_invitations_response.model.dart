import '../member.model.dart';

class SendInvitationsResponse {
  late List<Member> _members;

  List<Member> get members => _members;

  SendInvitationsResponse.fromObject(dynamic list) {
    List<dynamic> membersResponse = list;
    _members = membersResponse.map((s) => Member.fromObject(s)).toList();
  }
}
