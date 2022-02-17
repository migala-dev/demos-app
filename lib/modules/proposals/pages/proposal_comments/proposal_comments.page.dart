import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/member_comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

final fakeComments = <MemberCommentView>[
  MemberCommentView(
      commendId: '1',
      memberId: 'bbe6b0a4-5988-4717-8e4c-f8d7f7b2d515',
      profilePictureKey:
          'avatars/bc0e5b62-117d-45c4-af07-51818ccd3e0b.8846.jpg',
      memberName: 'Gendo Ikari',
      createdAt: '2022-2-15T02:54:29.907Z',
      upVotesCount: 5,
      downVotesCount: 2,
      content: 'Estoy a favor porque ...'),
  MemberCommentView(
      commendId: '1',
      memberId: 'bbe6b0a4-5988-4717-8e4c-f8d7f7b2d515',
      profilePictureKey:
          'avatars/bc0e5b62-117d-45c4-af07-51818ccd3e0b.8846.jpg',
      memberName: 'Gendo Ikari',
      createdAt: '2022-2-15T02:54:29.907Z',
      upVotesCount: 2,
      downVotesCount: 0,
      content: 'Bla bla bla...'),
  MemberCommentView(
      commendId: '1',
      memberId: 'bbe6b0a4-5988-4717-8e4c-f8d7f7b2d515',
      profilePictureKey:
          'avatars/bc0e5b62-117d-45c4-af07-51818ccd3e0b.8846.jpg',
      memberName: 'Gendo Ikari',
      createdAt: '2022-2-15T02:54:29.907Z',
      upVotesCount: 0,
      downVotesCount: 2,
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis lacinia est. Morbi elementum pellentesque lectus, eget hendrerit metus lacinia at. Sed sit amet sem blandit, tempor neque pellentesque, ultricies neque. Sed facilisis placerat velit, sit amet cursus lectus posuere luctus. Maecenas vitae efficitur justo. Aenean turpis quam, interdum nec convallis quis, laoreet hendrerit sapien. Nam fringilla ut elit vitae maximus. Donec ac risus in libero lacinia mattis. Maecenas feugiat diam non mauris venenatis consectetur. Nulla ac mi venenatis, sodales lacus ut, elementum nisi.')
];

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
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: fakeComments.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: MemberComment(comment: fakeComments[index]),
                ),
              )),
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
