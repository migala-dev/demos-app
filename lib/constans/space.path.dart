import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get-enviroment.dart';

class SpacePath {
  //  Space paths
  String getSpacePath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.spaceServiceUrl}/spaces';
  }

  String getUpdateSpaceImagePath(String spaceId) {
    return '${getSpacePath()}/$spaceId/picture';
  }
}
