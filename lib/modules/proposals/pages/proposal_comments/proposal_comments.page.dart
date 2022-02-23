import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_view.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class ProposalCommentsPage extends StatelessWidget {
  const ProposalCommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FutureBuilder(
              future: CommentViewService().getComments(),
              initialData: const <CommentView>[],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final comments = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MemberComment(
                        comment: comments[index], enableReplies: true),
                  ),
                );
              },
            ),
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextField(
            decoration: InputDecoration.collapsed(hintText: 'MENSAJE'),
          ),
        )
      ]),
    );
  }

  void goBack(BuildContext context) => Application.router.navigateTo(
        context,
        Routes.proposalDetails,
        transition: TransitionType.inFromTop,
      );
}
