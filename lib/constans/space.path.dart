import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get-enviroment.dart';

class SpacePath {
  //  Space paths
  String getSpacesPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.spaceServiceUrl}/spaces';
  }

  String getSpacePath(String spaceId) {
    return '${getSpacesPath()}/$spaceId';
  }

  String getInvitationPath(String spaceId) {
    return '${getSpacePath(spaceId)}/invitation';
  }

  String getAcceptInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/accept';
  }

  String getRejectInvitationPath(String spaceId) {
    return '${getInvitationPath(spaceId)}/reject';
  }

  String getUpdateSpaceImagePath(String spaceId) {
    return '${getSpacePath(spaceId)}/picture';
  }
}
