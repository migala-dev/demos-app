import '../space.model.dart';
import '../user.model.dart';
import '../member.model.dart';

class AllSpacesResponse {
  late List<Space> _spaces;
  late List<Member> _members;
  late List<User> _users;

  List<Space> get spaces => _spaces;
  List<Member> get members => _members;
  List<User> get users => _users;

  AllSpacesResponse.fromObject(dynamic o) {
    List<dynamic> spacesResponse = o['spaces'];
    _spaces = spacesResponse.map((s) => Space.fromObject(s)).toList();

    List<dynamic> membersResponse = o['members'];
    _members = membersResponse.map((s) => Member.fromObject(s)).toList();

    List<dynamic> usersResponse = o['users'];
    _users = usersResponse.map((m) => User.fromObject(m)).toList();
  }
}
