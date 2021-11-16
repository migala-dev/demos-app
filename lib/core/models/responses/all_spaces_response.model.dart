import '../space.model.dart';
import '../user.model.dart';
import '../member.model.dart';

class AllSpacesResponse {
  late List<Space> _spaces;
  late List<Member> _members;
  late List<User> _users;

  List<Space> get spaces => this._spaces;
  List<Member> get members => this._members;
  List<User> get users => this._users;

  AllSpacesResponse.fromObject(dynamic o) {
    List<dynamic> spacesResponse = o["spaces"];
    this._spaces = spacesResponse.map((s) => Space.fromObject(s)).toList();
    

    List<dynamic> membersResponse = o["members"];
    this._members = membersResponse.map((s) => Member.fromObject(s)).toList();
    
    List<dynamic> usersResponse = o["users"];
    this._users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}