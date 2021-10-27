

import '../role_user_space.model.dart';
import '../space.model.dart';
import '../user.model.dart';
import '../user_space.dart';

class AcceptInvitationResponse {
  late Space _space;
  late UserSpace _userSpace;
  late List<UserSpace> _members;
  late List<User> _users;
  late List<RoleUserSpace> _userRoles;

  Space get space => this._space;
  UserSpace get userSpace => this._userSpace;
  List<UserSpace> get members => this._members;
  List<User> get users => this._users;
  List<RoleUserSpace> get userRoles => this._userRoles;

  AcceptInvitationResponse.fromObject(dynamic o) {
    this._space = Space.fromObject(o["space"]);
    this._userSpace = UserSpace.fromObject(o["userSpace"]);
    
    List<dynamic> membersResponse = o["members"];
    this._members = membersResponse.map((m) => UserSpace.fromObject(m)).toList();
    
    List<dynamic> usersResponse = o["users"];
    this._users = usersResponse.map((m) => User.fromObject(m)).toList();

    List<dynamic> userRolesResponse = o["userRoles"];
    this._userRoles = userRolesResponse.map((m) => RoleUserSpace.fromObject(m)).toList();
  }
}
