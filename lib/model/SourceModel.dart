/// id : "string"
/// name : "string"
/// auth_id : "string"
/// source_type : "string"
/// url_album : "string"
/// api_version : "v1"
/// status : 0
/// password : "string"

class SourceModel {
  SourceModel({
      this.id, 
      this.name, 
      this.authId, 
      this.sourceType, 
      this.urlAlbum, 
      this.apiVersion, 
      this.status, 
      this.password,});

  SourceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    authId = json['auth_id'];
    sourceType = json['source_type'];
    urlAlbum = json['url_album'];
    apiVersion = json['api_version'];
    status = json['status'];
    password = json['password'];
  }
  String? id;
  String? name;
  String? authId;
  String? sourceType;
  String? urlAlbum;
  String? apiVersion;
  int? status;
  String? password;
SourceModel copyWith({  String? id,
  String? name,
  String? authId,
  String? sourceType,
  String? urlAlbum,
  String? apiVersion,
  int? status,
  String? password,
}) => SourceModel(  id: id ?? this.id,
  name: name ?? this.name,
  authId: authId ?? this.authId,
  sourceType: sourceType ?? this.sourceType,
  urlAlbum: urlAlbum ?? this.urlAlbum,
  apiVersion: apiVersion ?? this.apiVersion,
  status: status ?? this.status,
  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['auth_id'] = authId;
    map['source_type'] = sourceType;
    map['url_album'] = urlAlbum;
    map['api_version'] = apiVersion;
    map['status'] = status;
    map['password'] = password;
    return map;
  }

}