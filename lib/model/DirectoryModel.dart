/// path : "string"
/// fs_id : "string"
/// dir_empty : "string"

class DirectoryModel {
  DirectoryModel({
      this.path, 
      this.fsId, 
      this.dirEmpty,});

  DirectoryModel.fromJson(dynamic json) {
    path = json['path'];
    fsId = json['fs_id'];
    dirEmpty = json['dir_empty'];
  }
  String? path;
  String? fsId;
  String? dirEmpty;
DirectoryModel copyWith({  String? path,
  String? fsId,
  String? dirEmpty,
}) => DirectoryModel(  path: path ?? this.path,
  fsId: fsId ?? this.fsId,
  dirEmpty: dirEmpty ?? this.dirEmpty,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['fs_id'] = fsId;
    map['dir_empty'] = dirEmpty;
    return map;
  }

}