import 'package:demos_app/shared/services/date_formatter.service.dart';

class MemberCommentView {
  final String commendId;
  final String memberId;
  final String profilePictureKey;
  final String date;
  final String memberName;
  final int votesInFavor;
  final int votesInOpposing;
  final String content;

  String get dateFormatted =>
      DateFormatterService.parseToDayMonthYearHourDate(date);

  MemberCommentView(
      {required this.commendId,
      required this.memberId,
      required this.profilePictureKey,
      required this.memberName,
      required this.date,
      required this.votesInFavor,
      required this.votesInOpposing,
      required this.content});
}
