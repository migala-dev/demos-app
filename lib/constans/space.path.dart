import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get-enviroment.dart';

class SpacePath {
  String getSpacesPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.spaceServiceUrl}/spaces';
  }

  String getSpacePath(String spaceId) {
    return '${getSpacesPath()}/$spaceId';
  }

  String getUpdateSpaceImagePath(String spaceId) {
    return '${getSpacePath(spaceId)}/picture';
  }

}
