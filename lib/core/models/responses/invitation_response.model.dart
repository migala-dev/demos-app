
import '../user_space.dart';

class InvitationResponse {
  late UserSpace _userSpace;
  
  UserSpace get userSpace => this._userSpace;
  
  InvitationResponse.fromObject(dynamic o) {
    this._userSpace = UserSpace.fromObject(o["userSpace"]);
  }
}