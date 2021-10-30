import 'package:demos_app/modules/spaces/models/space_view.model.dart';

class Space {
  String? _spaceId;
  String? _name;
  String? _description;
  String? _pictureKey;
  int _approvalPercentage = 51;
  int _participationPercentage = 51;
  String? _ownerId;
  String? _createdAt;
  String? _updatedAt;

  String? get spaceId => this._spaceId;
  String? get name => this._name;
  String? get description => this._description;
  String? get pictureKey => this._pictureKey;
  int get participationPercentage => this._participationPercentage;
  int get approvalPercentage => this._approvalPercentage;
  String? get createdAt => this._createdAt;
  String? get updatedAt => this._updatedAt;

  set name(String? name) => this._name = name;
  set description(String? description) => this._description = description;
  set participationPercentage(int p) => this._participationPercentage = p;
  set approvalPercentage(int a) => this._approvalPercentage = a;

  Space();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["spaceId"] = _spaceId;
    map["name"] = _name;
    map["description"] = _description;
    map["pictureKey"] = _pictureKey;
    map["approvalPercentage"] = _approvalPercentage;
    map["participationPercentage"] = _participationPercentage;
    map["ownerId"] = _ownerId;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

  Space.fromObject(dynamic o) {
    this._spaceId = o["spaceId"];
    this._name = o["name"];
    this._description = o["description"];
    this._pictureKey = o["pictureKey"];
    this._approvalPercentage = o["approvalPercentage"];
    this._participationPercentage = o["participationPercentage"];
    this._ownerId = o["ownerId"];
    this._createdAt = o["createdAt"];
    this._updatedAt = o["updatedAt"];
  }

  SpaceView toSpapceView() {
    return SpaceView(
          spaceId: spaceId ?? '',
          name: name ?? '',
          pictureKey: pictureKey);
  }
}
