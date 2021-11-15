import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';

class MemberView {
  final String userId;
  final String? memberId;
  final String? spaceId;
  final String? name;
  final String? phoneNumber;
  final String? profilePictureKey;
  final SpaceRole? role;
  final int noParticipations;
  final InvitationStatus? invitationStatus;
  final String createdAt;

  String get displayName {
    if (this.name != null) if (this.name!.length > 0) return this.name!;

    if (this.phoneNumber != null) return this.phoneNumber!;

    return 'Miembro';
  }

  MemberType get memberType {
    if (this.role == null) return MemberType.INVITED;
    if (this.invitationStatus == InvitationStatus.SENDED)
      return MemberType.INVITED;

    switch (this.role) {
      case SpaceRole.ADMIN:
        return MemberType.ADMINISTRATOR;
      case SpaceRole.WORKER:
        return MemberType.WORKER;
      default:
        return MemberType.WORKER;
    }
  }

  MemberView({
    required this.userId,
    required this.noParticipations,
    required this.role,
    required this.createdAt,
    this.invitationStatus,
    this.profilePictureKey,
    this.memberId,
    this.spaceId,
    this.name,
    this.phoneNumber,
  });
}
