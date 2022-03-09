import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';

class CommentViewRepository {
  Future<List<CommentView>> findByProposalId(String proposalId) async {
    final member = MemberView(
        userId: '1',
        role: SpaceRole.admin,
        memberCreatedAt: '',
        profilePictureKey:
            'avatars/bc0e5b62-117d-45c4-af07-51818ccd3e0b.8846.jpg',
        memberName: 'Gendo Ikari');

    final member2 = MemberView(
        userId: '2',
        role: SpaceRole.representative,
        memberCreatedAt: '',
        profilePictureKey:
            'avatars/45467b1e-fabc-4540-87c7-33eb82ccfe9e.9914.jpg',
        memberName: 'Musato Katsuragi');

    final replies = <CommentView>[
      CommentView(
        commendId: '1',
        member: member2,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 5,
        downVotesCount: 2,
        content: 'Sugerencia...',
      ),
      CommentView(
        commendId: '1',
        member: member2,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 2,
        downVotesCount: 0,
        content: 'Estás mal y te voy a decir por qué',
      ),
      CommentView(
        commendId: '1',
        member: member2,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 0,
        downVotesCount: 2,
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis lacinia est. Morbi elementum pellentesque lectus, eget hendrerit metus lacinia at. Sed sit amet sem blandit, tempor neque pellentesque, ultricies neque. Sed facilisis placerat velit, sit amet cursus lectus posuere luctus. Maecenas vitae efficitur justo. Aenean turpis quam, interdum nec convallis quis, laoreet hendrerit sapien. Nam fringilla ut elit vitae maximus. Donec ac risus in libero lacinia mattis. Maecenas feugiat diam non mauris venenatis consectetur. Nulla ac mi venenatis, sodales lacus ut, elementum nisi.',
      )
    ];

    return <CommentView>[
      CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 2,
        downVotesCount: 0,
        content: 'Bla bla bla...',
        replies: [...replies, ...replies],
      ),
      CommentView(
          commendId: '1',
          member: member,
          createdAt: '2022-2-15T02:54:29.907Z',
          upVotesCount: 5,
          downVotesCount: 2,
          content: 'Estoy a favor porque ...',
          replies: replies),
      CommentView(
        commendId: '1',
        member: member,
        createdAt: '2022-2-15T02:54:29.907Z',
        upVotesCount: 0,
        downVotesCount: 2,
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis lacinia est. Morbi elementum pellentesque lectus, eget hendrerit metus lacinia at. Sed sit amet sem blandit, tempor neque pellentesque, ultricies neque. Sed facilisis placerat velit, sit amet cursus lectus posuere luctus. Maecenas vitae efficitur justo. Aenean turpis quam, interdum nec convallis quis, laoreet hendrerit sapien. Nam fringilla ut elit vitae maximus. Donec ac risus in libero lacinia mattis. Maecenas feugiat diam non mauris venenatis consectetur. Nulla ac mi venenatis, sodales lacus ut, elementum nisi.',
      )
    ];
  }
}
