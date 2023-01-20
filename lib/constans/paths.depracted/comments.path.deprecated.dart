import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class CommentsPathDeprecated {
  String getCommentsPath() {
    final Enviroment enviroment = getDeprecatedEnviroment();
    return '${enviroment.manifestoServiceUrl}/comments';
  }

  String getSpaceCommentPath(String spaceId) => '${getCommentsPath()}/$spaceId';

  String getManifestoCommentPath(String spaceId, String manifestoId) =>
      '${getSpaceCommentPath(spaceId)}/$manifestoId';

  String getReplyManifestoCommentPath(String spaceId, String manifestoId,
          String manifestoCommentParentId) =>
      '${getSpaceCommentPath(spaceId)}/$manifestoId/$manifestoCommentParentId';
}
