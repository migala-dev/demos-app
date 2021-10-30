import '../user_space.dart';

class SendInvitationsResponse {
  late List<UserSpace> _userSpaces;
  
  List<UserSpace> get userSpaces => this._userSpaces;
  
  SendInvitationsResponse.fromObject(dynamic list) {
    List<dynamic> userSpacesResponse = list;
    this._userSpaces = userSpacesResponse.map((s) => UserSpace.fromObject(s)).toList();
  }
}