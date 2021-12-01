import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class MemberPath {
  String getMembersPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.spaceServiceUrl}/members';
  }

  String getMembersSpacePath(String spaceId) {
    return '${getMembersPath()}/$spaceId';
  }

  String getInvitationPath(String spaceId) {
    return '${getMembersSpacePath(spaceId)}/invitation';
  }

  String getAcceptInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/accept';
  }

  String getRejectInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/reject';
  }

  String getMemberPath(String spaceId, String memberId) {
    return '${getMembersSpacePath(spaceId)}/$memberId';
  }

}
