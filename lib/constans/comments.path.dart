import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class CommentsPath {
  String getCommentsPath() {
    final Enviroment enviroment = getEnviroment();
    return '${enviroment.manifestoServiceUrl}/comments';
  }

  String getSpaceCommentPath(String spaceId) => '${getCommentsPath()}/$spaceId';

  String getManifestoCommentPath(String spaceId, String manifestoId) =>
      '${getSpaceCommentPath(spaceId)}/$manifestoId';
}
