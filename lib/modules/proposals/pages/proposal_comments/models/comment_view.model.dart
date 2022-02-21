import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class CommentView {
  final String commendId;
  final MemberView member;
  final String createdAt;
  final int upVotesCount;
  final int downVotesCount;
  final String content;
  final int repliesCount;

  String get createdAtFormatted =>
      DateFormatterService.parseToDayMonthYearHourDate(createdAt);

  CommentView(
      {required this.commendId,
      required this.member,
      required this.createdAt,
      required this.upVotesCount,
      required this.downVotesCount,
      required this.content,
      required this.repliesCount});
}
