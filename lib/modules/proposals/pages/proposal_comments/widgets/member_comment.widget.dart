import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/buttons/reply_button.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/comment_votes_count.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/buttons/replies_count_button.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/subcomments_list_view.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';

class MemberComment extends StatelessWidget {
  final CommentView comment;
  final bool isSubcomment;
  final EdgeInsetsGeometry padding;
  const MemberComment(
      {Key? key,
      required this.comment,
      this.isSubcomment = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 18)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ExpansionWidget(
        titleBuilder:
            (animationValue, easeInValue, isExpanded, toggleFunction) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProfilePicture(
                  imageKey: comment.member.profilePictureKey,
                  width: 40,
                  percentage: 0.9,
                ),
                const SizedBox(width: 10),
                Text(
                  '${comment.member.displayName} ',
                  overflow: TextOverflow.clip,
                ),
                Text(comment.createdAtFormatted,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.grey, fontSize: 12))
              ],
            ),
            const SizedBox(height: 15),
            Text(comment.content,
                style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommentVotesCount(
                    votesInFavor: comment.upVotesCount,
                    votesInOpposing: comment.downVotesCount),
                const SizedBox(width: 10),
                comment.repliesCount > 0 && !isSubcomment
                    ? RepliesCountButton(
                        onTap: toggleFunction,
                        repliesCount: comment.repliesCount)
                    : Container(),
                const SizedBox(width: 5),
                !isSubcomment ? ReplyButton(onTap: () {}) : Container(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.grey))
              ],
            )
          ],
        ),
        content: isSubcomment ? Container() : const SubCommentsListView(),
      ),
    );
  }
}
