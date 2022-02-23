import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:flutter/material.dart';

class RepliesListView extends StatelessWidget {
  final List<CommentView> replies;

  const RepliesListView({Key? key, required this.replies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey))),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: replies.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: MemberComment(
              comment: replies[index],
              padding: const EdgeInsets.only(left: 10)),
        ),
      ),
    );
  }
}
