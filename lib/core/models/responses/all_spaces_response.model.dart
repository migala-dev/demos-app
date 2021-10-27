import '../role_user_space.model.dart';
import '../space.model.dart';
import '../user.model.dart';
import '../user_space.dart';

class AllSpacesResponse {
  late List<Space> _spaces;
  late List<UserSpace> _userSpaces;
  late List<User> _users;
  late List<RoleUserSpace> _roleUsers;

  List<Space> get spaces => this._spaces;
  List<UserSpace> get userSpaces => this._userSpaces;
  List<User> get users => this._users;
  List<RoleUserSpace> get roleUsers => this._roleUsers;

  AllSpacesResponse.fromObject(dynamic o) {
    List<dynamic> spacesResponse = o["spaces"];
    this._spaces = spacesResponse.map((s) => Space.fromObject(s)).toList();
    

    List<dynamic> userSpacesResponse = o["userSpaces"];
    this._userSpaces = userSpacesResponse.map((s) => UserSpace.fromObject(s)).toList();
    
    List<dynamic> usersResponse = o["users"];
    this._users = usersResponse.map((m) => User.fromObject(m)).toList();

    List<dynamic> roleUsersResponse = o["roleUserSpaces"];
    this._roleUsers = roleUsersResponse.map((m) => RoleUserSpace.fromObject(m)).toList();
  }
}