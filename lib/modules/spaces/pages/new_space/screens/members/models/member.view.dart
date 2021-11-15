import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';

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
