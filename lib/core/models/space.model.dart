import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class Space {
  String? _spaceId;
  String? _pictureKey;
  String? _ownerId;
  String? _createdAt;
  String? _updatedAt;
  String? name;
  String? description;
  int participationPercentage = 51;
  int approvalPercentage = 51;

  String? get spaceId => _spaceId;
  String? get pictureKey => _pictureKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String get createdAtFormatted =>
      DateFormatterService.parseToStandardDate(_createdAt ?? '');

  Space();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['spaceId'] = _spaceId;
    map['name'] = name;
    map['description'] = description;
    map['pictureKey'] = _pictureKey;
    map['approvalPercentage'] = approvalPercentage;
    map['participationPercentage'] = participationPercentage;
    map['ownerId'] = _ownerId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  Space.fromObject(dynamic o) {
    _spaceId = o['spaceId'];
    name = o['name'];
    description = o['description'];
    _pictureKey = o['pictureKey'];
    approvalPercentage = o['approvalPercentage'];
    participationPercentage = o['participationPercentage'];
    _ownerId = o['ownerId'];
    _createdAt = o['createdAt'];
    _updatedAt = o['updatedAt'];
  }

  SpaceView toSpapceView() {
    return SpaceView(
        spaceId: spaceId ?? '', name: name ?? '', pictureKey: pictureKey);
  }
}
