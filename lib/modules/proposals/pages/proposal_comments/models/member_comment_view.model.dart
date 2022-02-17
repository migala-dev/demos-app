import 'package:demos_app/shared/services/date_formatter.service.dart';

class MemberCommentView {
  // CommentView
  final String commendId;
  final String memberId; // Cambiar por memberView
  final String profilePictureKey;
  final String createdAt;
  final String memberName;
  final int upVotesCount;
  final int downVotesCount;
  final String content;

  // List<MemberCommentView> subcomments; // Usar el id padre

  String get createdAtFormatted =>
      DateFormatterService.parseToDayMonthYearHourDate(createdAt);

  MemberCommentView(
      {required this.commendId,
      required this.memberId,
      required this.profilePictureKey,
      required this.memberName,
      required this.createdAt,
      required this.upVotesCount,
      required this.downVotesCount,
      required this.content});
}
