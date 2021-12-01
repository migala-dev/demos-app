import '../space.model.dart';
import '../user.model.dart';
import '../member.model.dart';

class AcceptInvitationResponse {
  late Space _space;
  late List<Member> _members;
  late List<User> _users;

  Space get space => _space;
  List<Member> get members => _members;
  List<User> get users => _users;

  AcceptInvitationResponse.fromObject(dynamic o) {
    _space = Space.fromObject(o['space']);

    List<dynamic> membersResponse = o['members'];
    _members = membersResponse.map((m) => Member.fromObject(m)).toList();

    List<dynamic> usersResponse = o['users'];
    _users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}
