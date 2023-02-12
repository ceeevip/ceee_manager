/// path : "string"
/// fs_id : "string"
/// is_empty : "false"

class DirectoryModel {
  DirectoryModel({
      this.path, 
      this.fsId, 
      this.isEmpty,});

  DirectoryModel.fromJson(dynamic json) {
    path = json['path'];
    fsId = json['fs_id'];
    isEmpty = json['is_empty'];
  }
  String? path;
  String? fsId;
  String? isEmpty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['fs_id'] = fsId;
    map['is_empty'] = isEmpty;
    return map;
  }

}