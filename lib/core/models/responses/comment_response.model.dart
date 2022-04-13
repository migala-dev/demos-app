import 'package:demos_app/core/models/manifesto/comment/manifesto_comment.model.dart';

class CommentResponse {
  final ManifestoComment comment;

  CommentResponse(this.comment);

  factory CommentResponse.fromObject(dynamic o) =>
      CommentResponse(ManifestoComment.fromObject(o['manifestoComment']));
}
