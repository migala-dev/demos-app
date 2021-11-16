

import '../space.model.dart';
import '../user.model.dart';
import '../member.model.dart';

class AcceptInvitationResponse {
  late Space _space;
  late List<Member> _members;
  late List<User> _users;

  Space get space => this._space;
  List<Member> get members => this._members;
  List<User> get users => this._users;


  AcceptInvitationResponse.fromObject(dynamic o) {
    this._space = Space.fromObject(o["space"]);
    
    List<dynamic> membersResponse = o["members"];
    this._members = membersResponse.map((m) => Member.fromObject(m)).toList();
    
    List<dynamic> usersResponse = o["users"];
    this._users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}
