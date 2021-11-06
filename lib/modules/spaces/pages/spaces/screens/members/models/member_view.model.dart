import 'package:demos_app/core/enums/space-role.enum.dart';

class MemberView {
  final String userId;
  final String? name;
  final SpaceRole? role;
  final int noParticipations;
  final DateTime? invitationExpiration;
  final String? profilePictureKey;

  MemberView(
      {required this.userId,
      this.name,
      this.role,
      required this.noParticipations,
      this.invitationExpiration,
      this.profilePictureKey});
}
