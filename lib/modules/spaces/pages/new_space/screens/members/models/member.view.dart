import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/shared/services/phone_formatter.service.dart';

class MemberView {
  final String userId;
  final String? memberId;
  final String? spaceId;
  final String? userName;
  final String? phoneNumber;
  final String? profilePictureKey;
  final int participationCount;
  final InvitationStatus? invitationStatus;
  final String? memberCreatedAt;
  SpaceRole? role;
  String? memberName;

  String get displayName {
    if (this.memberName != null) if (this.memberName!.length > 0)
      return this.memberName!;

    if (this.userName != null) if (this.userName!.length > 0)
      return this.userName!;

    if (this.phoneNumber != null) return this.phoneNumberFormatted;

    return 'Sin Nombre';
  }

  String get memberCreatedAtFormatted =>
      DateFormatterService.parseToStandardDate(this.memberCreatedAt ?? '');

  String get phoneNumberFormatted =>
      PhoneFormatterService.format(this.phoneNumber);

  MemberType get memberType {
    if (this.role == null) return MemberType.INVITED;
    if (this.invitationStatus == InvitationStatus.SENDED)
      return MemberType.INVITED;

    switch (this.role) {
      case SpaceRole.ADMIN:
        return MemberType.ADMINISTRATOR;
      case SpaceRole.WORKER:
        return MemberType.WORKER;
      case SpaceRole.REPRESENTATIVE:
        return MemberType.REPRESENTATIVE;
      default:
        return MemberType.WORKER;
    }
  }

  bool get isInvited => this.memberType == MemberType.INVITED;

  MemberView({
    required this.userId,
    required this.participationCount,
    required this.role,
    required this.memberCreatedAt,
    this.memberName,
    this.invitationStatus,
    this.profilePictureKey,
    this.memberId,
    this.spaceId,
    this.userName,
    this.phoneNumber,
  });
}
