import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/comment_votes_count.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/replies_count_button.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class MemberComment extends StatelessWidget {
  final CommentView comment;
  const MemberComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
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
          Text(comment.content, style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              comment.repliesCount > 0
                  ? RepliesCountButton(
                      onTap: () {}, repliesCount: comment.repliesCount)
                  : Container(),
              const SizedBox(width: 5),
              CommentVotesCount(
                  votesInFavor: comment.upVotesCount,
                  votesInOpposing: comment.downVotesCount),
              const SizedBox(width: 10),
              const Icon(
                Icons.reply_outlined,
                color: Colors.grey,
              ),
              const SizedBox(width: 2),
              const Text('Responder'),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}