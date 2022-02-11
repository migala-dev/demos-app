import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

class InvitationView extends SpaceView {
  final String createAt;
  final String expiredAt;
  final User invitedBy;

  InvitationView(
      {required this.createAt,
      required this.expiredAt,
      required this.invitedBy,
      required spaceId,
      required name,
      pictureKey})
      : super(spaceId: spaceId, name: name, pictureKey: pictureKey);

  factory InvitationView.fromObject(Map<String, dynamic> o) => InvitationView(
      createAt: o['memberCreateAt'],
      expiredAt: o['expiredAt'],
      invitedBy: User.fromObject(o),
      spaceId: o['spaceId'],
      name: o['spaceName'],
      pictureKey: o['pictureKey']);
}
