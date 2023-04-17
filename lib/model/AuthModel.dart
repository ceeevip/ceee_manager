/// id : "string"
/// type : "string"
/// avatar_url : "string"
/// name : "string"
/// alias_name : "string"
/// init_path : "string"

class AuthModel {
  AuthModel({
      this.id, 
      this.type, 
      this.avatarUrl, 
      this.name, 
      this.aliasName, 
      this.initPath,});

  AuthModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    avatarUrl = json['avatar_url'];
    name = json['name'];
    aliasName = json['alias_name'];
    initPath = json['init_path'];
  }
  String? id;
  String? type;
  String? avatarUrl;
  String? name;
  String? aliasName;
  String? initPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['avatar_url'] = avatarUrl;
    map['name'] = name;
    map['alias_name'] = aliasName;
    map['init_path'] = initPath;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}