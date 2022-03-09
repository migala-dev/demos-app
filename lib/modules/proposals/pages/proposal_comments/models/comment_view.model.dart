import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class CommentView {
  final String commendId;
  final MemberView member;
  final String createdAt;
  final int upVotesCount;
  final int downVotesCount;
  final String content;

  final List<CommentView>? replies;

  String get createdAtFormatted =>
      DateFormatterService.parseToDayMonthYearHourDate(createdAt);

  int get repliesCount => replies == null ? 0 : replies!.length;

  CommentView(
      {required this.commendId,
      required this.member,
      required this.createdAt,
      required this.upVotesCount,
      required this.downVotesCount,
      required this.content,
      this.replies});
}
