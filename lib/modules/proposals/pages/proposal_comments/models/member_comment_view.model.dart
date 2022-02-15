class MemberCommentView {
  final String commendId;
  final String userId;
  final String memberId;
  final String date;
  final String name;
  final int votesInFavor;
  final int votesInOpposing;
  final String content;

  MemberCommentView(
      {required this.commendId,
      required this.userId,
      required this.memberId,
      required this.name,
      required this.date,
      required this.votesInFavor,
      required this.votesInOpposing,
      required this.content});
}
