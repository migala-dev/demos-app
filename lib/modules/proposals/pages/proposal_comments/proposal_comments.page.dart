import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Future<List<CommentView>> _getFakeComments() async {
  final member = MemberView(
      userId: '1',
      role: SpaceRole.admin,
      memberCreatedAt: '',
      profilePictureKey:
          'avatars/bc0e5b62-117d-45c4-af07-51818ccd3e0b.8846.jpg',
      memberName: 'Gendo Ikari');

  return <CommentView>[
    CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 5,
        downVotesCount: 2,
        content: 'Estoy a favor porque ...',
        repliesCount: 0),
    CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 2,
        downVotesCount: 0,
        content: 'Bla bla bla...',
        repliesCount: 3),
    CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 0,
        downVotesCount: 2,
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis lacinia est. Morbi elementum pellentesque lectus, eget hendrerit metus lacinia at. Sed sit amet sem blandit, tempor neque pellentesque, ultricies neque. Sed facilisis placerat velit, sit amet cursus lectus posuere luctus. Maecenas vitae efficitur justo. Aenean turpis quam, interdum nec convallis quis, laoreet hendrerit sapien. Nam fringilla ut elit vitae maximus. Donec ac risus in libero lacinia mattis. Maecenas feugiat diam non mauris venenatis consectetur. Nulla ac mi venenatis, sodales lacus ut, elementum nisi.',
        repliesCount: 2)
  ];
}

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
              future: _getFakeComments(),
              initialData: const <CommentView>[],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final fakeComments = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: fakeComments.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MemberComment(comment: fakeComments[index]),
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
