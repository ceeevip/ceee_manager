/// id : "string"
/// name : "string"
/// auth_id : "string"
/// source_type : "string"
/// cover : "string"
/// api_version : "v1"
/// status : 0
/// password : "string"
/// file_type : "audio"

class SourceModel {
  SourceModel({
      this.id, 
      this.name, 
      this.authId, 
      this.sourceType, 
      this.cover, 
      this.apiVersion, 
      this.status, 
      this.password, 
      this.fileType,});

  SourceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    authId = json['auth_id'];
    sourceType = json['source_type'];
    cover = json['cover'];
    apiVersion = json['api_version'];
    status = json['status'];
    password = json['password'];
    fileType = json['file_type'];
  }
  String? id;
  String? name;
  String? authId;
  String? sourceType;
  String? cover;
  String? apiVersion;
  int? status;
  String? password;
  String? fileType;
SourceModel copyWith({  String? id,
  String? name,
  String? authId,
  String? sourceType,
  String? cover,
  String? apiVersion,
  int? status,
  String? password,
  String? fileType,
}) => SourceModel(  id: id ?? this.id,
  name: name ?? this.name,
  authId: authId ?? this.authId,
  sourceType: sourceType ?? this.sourceType,
  cover: cover ?? this.cover,
  apiVersion: apiVersion ?? this.apiVersion,
  status: status ?? this.status,
  password: password ?? this.password,
  fileType: fileType ?? this.fileType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['auth_id'] = authId;
    map['source_type'] = sourceType;
    map['cover'] = cover;
    map['api_version'] = apiVersion;
    map['status'] = status;
    map['password'] = password;
    map['file_type'] = fileType;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}