/// path : "string"
/// fs_id : "string"
/// source_id : "string"
/// name : "string"
/// album_url : "string"
/// id : "string"

class AlbumModel {
  AlbumModel({
      this.path, 
      this.fsId, 
      this.sourceId, 
      this.name, 
      this.albumUrl, 
      this.id,});

  AlbumModel.fromJson(dynamic json) {
    path = json['path'];
    fsId = json['fs_id'];
    sourceId = json['source_id'];
    name = json['name'];
    albumUrl = json['album_url'];
    id = json['id'];
  }
  String? path;
  String? fsId;
  String? sourceId;
  String? name;
  String? albumUrl;
  String? id;
AlbumModel copyWith({  String? path,
  String? fsId,
  String? sourceId,
  String? name,
  String? albumUrl,
  String? id,
}) => AlbumModel(  path: path ?? this.path,
  fsId: fsId ?? this.fsId,
  sourceId: sourceId ?? this.sourceId,
  name: name ?? this.name,
  albumUrl: albumUrl ?? this.albumUrl,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['fs_id'] = fsId;
    map['source_id'] = sourceId;
    map['name'] = name;
    map['album_url'] = albumUrl;
    map['id'] = id;
    return map;
  }

}