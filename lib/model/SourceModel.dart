class SourceModel {
  SourceModel({
      this.id, 
      this.name, 
      this.authId, 
      this.sourceType, 
      this.urlAlbum, 
      this.apiVersion, 
      this.status,});

  SourceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    authId = json['auth_id'];
    sourceType = json['source_type'];
    urlAlbum = json['url_album'];
    apiVersion = json['api_version'];
    status = json['status'];
  }
  String? id;
  String? name;
  String? authId;
  String? sourceType;
  String? urlAlbum;
  String? apiVersion;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['auth_id'] = authId;
    map['source_type'] = sourceType;
    map['url_album'] = urlAlbum;
    map['api_version'] = apiVersion;
    map['status'] = status;
    return map;
  }

}