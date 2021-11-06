import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/repositories/role_user_space.repository.dart';
import 'package:demos_app/core/repositories/user_space.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/members/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/current_space.service.dart';
import 'package:demos_app/core/models/space.model.dart';

class SpacesMembersService {
  static final _membersService = SpacesMembersService._internal();
  SpacesMembersService._internal();

  factory SpacesMembersService() => _membersService;

  Future<List<MemberView>> getSpaceMembers() async {
    final List<MemberView> members = [];
    final Space? currentSpace = CurrentSpaceService().getCurrentSpace();
    final String? spaceId = currentSpace?.spaceId;

    final usersSpaceRepository = UserSpaceRepository();
    final roleUserSpaceRepository = RoleUserSpaceRepository();
    final usersSpace = await usersSpaceRepository.getUsersBySpaceId(spaceId!);

    final usersRepository = UsersRepository();
    usersSpace.forEach((userSpace) async {
      final user = await usersRepository.findById('${userSpace['userId']}');
      final rolUser =
          await roleUserSpaceRepository.findByUserId('${userSpace['userId']}');
      final SpaceRole? spaceRole = rolUser?.role;

      final member = MemberView(
          userId: user?.userId ?? '',
          name: user?.name,
          role: spaceRole ?? SpaceRole.INVITED,
          noParticipations: 0,
          profilePictureKey: user?.profilePictureKey);

      members.add(member);
    });

    return members;
  }
}
