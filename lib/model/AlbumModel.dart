/// id : "string"
/// path : "string"
/// fs_id : "string"
/// source_id : "string"
/// name : "string"
/// cover : "string"
/// enable_search : 1
/// memo : "string"

class AlbumModel {
  AlbumModel({
      this.id, 
      this.path, 
      this.fsId, 
      this.sourceId, 
      this.name, 
      this.cover, 
      this.enableSearch, 
      this.memo,});

  AlbumModel.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
    fsId = json['fs_id'];
    sourceId = json['source_id'];
    name = json['name'];
    cover = json['cover'];
    enableSearch = json['enable_search'];
    memo = json['memo'];
  }
  String? id;
  String? path;
  String? fsId;
  String? sourceId;
  String? name;
  String? cover;
  num? enableSearch;
  String? memo;
AlbumModel copyWith({  String? id,
  String? path,
  String? fsId,
  String? sourceId,
  String? name,
  String? cover,
  num? enableSearch,
  String? memo,
}) => AlbumModel(  id: id ?? this.id,
  path: path ?? this.path,
  fsId: fsId ?? this.fsId,
  sourceId: sourceId ?? this.sourceId,
  name: name ?? this.name,
  cover: cover ?? this.cover,
  enableSearch: enableSearch ?? this.enableSearch,
  memo: memo ?? this.memo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['path'] = path;
    map['fs_id'] = fsId;
    map['source_id'] = sourceId;
    map['name'] = name;
    map['cover'] = cover;
    map['enable_search'] = enableSearch;
    map['memo'] = memo;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumModel &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          name == other.name;

  @override
  int get hashCode => path.hashCode ^ name.hashCode;
}