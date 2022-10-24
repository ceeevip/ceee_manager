/// id : "1"
/// type : "bdp"
/// avatar_url : "https://dss0.bdstatic.com/7Ls0a8Sm1A5BphGlnYG/sys/portrait/item/netdisk.1.c271bd87.CDfCGF36OdUBEVLwioRRYw.jpg"
/// name : "yinlei126"
/// alias_name : "ddfwq111"

class AuthModel {
  AuthModel({
      String? id, 
      String? type, 
      String? avatarUrl, 
      String? name, 
      String? aliasName,}){
    _id = id;
    _type = type;
    _avatarUrl = avatarUrl;
    _name = name;
    _aliasName = aliasName;
}

  AuthModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _avatarUrl = json['avatar_url'];
    _name = json['name'];
    _aliasName = json['alias_name'];
  }
  String? _id;
  String? _type;
  String? _avatarUrl;
  String? _name;
  String? _aliasName;
AuthModel copyWith({  String? id,
  String? type,
  String? avatarUrl,
  String? name,
  String? aliasName,
}) => AuthModel(  id: id ?? _id,
  type: type ?? _type,
  avatarUrl: avatarUrl ?? _avatarUrl,
  name: name ?? _name,
  aliasName: aliasName ?? _aliasName,
);
  String? get id => _id;
  String? get type => _type;
  String? get avatarUrl => _avatarUrl;
  String? get name => _name;
  String? get aliasName => _aliasName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['avatar_url'] = _avatarUrl;
    map['name'] = _name;
    map['alias_name'] = _aliasName;
    return map;
  }

}