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
  String? invitationExpiredAt;
  SpaceRole? role;
  String? memberName;

  String get displayName {
    if (memberName != null) if (memberName!.isNotEmpty) return memberName!;

    if (userName != null) if (userName!.isNotEmpty) return userName!;

    if (phoneNumber != null) return phoneNumberFormatted;

    return 'Sin Nombre';
  }

  String get memberCreatedAtFormatted =>
      DateFormatterService.parseToStandardDate(memberCreatedAt ?? '');

  String get phoneNumberFormatted => PhoneFormatterService.format(phoneNumber);

  String get invitationExpiredAtFormatted =>
      DateFormatterService.parseToStandardDate(invitationExpiredAt ?? '');

  MemberType get memberType {
    if (role == null) return MemberType.invited;
    if (invitationStatus == InvitationStatus.sended) return MemberType.invited;

    switch (role) {
      case SpaceRole.admin:
        return MemberType.administrator;
      case SpaceRole.worker:
        return MemberType.worker;
      case SpaceRole.representative:
        return MemberType.representative;
      default:
        return MemberType.worker;
    }
  }

  bool get isInvited => memberType == MemberType.invited;

  MemberView(
      {required this.userId,
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
      this.invitationExpiredAt});
}
