/// id : "string"
/// name : "string"
/// email : "user@example.com"
/// create_time : "2022-11-05T15:07:21.333Z"

class UserInfo {
  UserInfo({
      this.id, 
      this.name, 
      this.email, 
      this.createTime,});

  UserInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createTime = json['create_time'];
  }
  String? id;
  String? name;
  String? email;
  String? createTime;
UserInfo copyWith({  String? id,
  String? name,
  String? email,
  String? createTime,
}) => UserInfo(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  createTime: createTime ?? this.createTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['create_time'] = createTime;
    return map;
  }

}