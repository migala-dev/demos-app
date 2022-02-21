import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/member_comment.widget.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:flutter/material.dart';

Future<List<CommentView>> _getFakeComments() async {
  final member = MemberView(
      userId: '1',
      role: SpaceRole.admin,
      memberCreatedAt: '',
      profilePictureKey:
          'avatars/45467b1e-fabc-4540-87c7-33eb82ccfe9e.9914.jpg',
      memberName: 'Musato Katsuragi');

  return <CommentView>[
    CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 5,
        downVotesCount: 2,
        content: 'Sugerencia...',
        repliesCount: 0),
    CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 2,
        downVotesCount: 0,
        content: 'Estás mal y te voy a decir por qué',
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

class SubCommentsListView extends StatelessWidget {
  const SubCommentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFakeComments(),
      initialData: const <CommentView>[],
      builder:
          (BuildContext context, AsyncSnapshot<List<CommentView>> snapshot) {
        final fakeComments = snapshot.data;
        if (!snapshot.hasData) {
          return const Text('Cargando');
        }
        return Container(
          margin: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey))),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: fakeComments!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: MemberComment(
                  comment: fakeComments[index],
                  enableReplies: true,
                  padding: const EdgeInsets.only(left: 10)),
            ),
          ),
        );
      },
    );
  }
}
