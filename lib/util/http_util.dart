import 'package:ceee_manager/core/CeeeException.dart';
import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/DirectoryModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/model/mymodels.dart';
import 'package:dio/dio.dart';

import '../model/UserInfo.dart';

class HttpDio {
  static Dio dio = Dio();

  static initOptions(String base_url, Map<String, dynamic> headers) {
    dio.options.baseUrl = base_url;
    dio.options.headers.addAll(headers);
  }

  static Future<LoginResponseEntity> login_token(
      String base_url, String email, String pwd) async {
    try {
      var formData = FormData.fromMap({"username": email, "password": pwd});
      var response = await dio.post(
        "${base_url}/auth/token",
        options: Options(receiveDataWhenStatusError: true),
        data: formData,
      );
      return LoginResponseEntity(true,
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token'],
          tokenType: response.data['token_type']);
    } on DioError catch (e) {
      print(e.response);
      return LoginResponseEntity(false, msg: "${e.response}");
    }
  }

  static Future<UserInfo> user_info() async {
    try {
      var resp = await dio.get("/auth/user_info");
      if (resp.statusCode == 200) {
        return UserInfo.fromJson(resp.data);
      } else {
        throw CeeeException("错误");
      }
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<SourceModel>?> sources_list() async {
    try {
      List<SourceModel> rs = [];
      var jsStr = await dio.get("/auth/list_source");
      for (var source in jsStr.data) {
        rs.add(SourceModel.fromJson(source));
      }
      return rs;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<AuthModel>?> auths_list() async {
    try {
      List<AuthModel> rs = [];
      var jsStr = await dio.get("/auth/list_auths");
      for (var source in jsStr.data) {
        rs.add(AuthModel.fromJson(source));
      }
      return rs;
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<SourceModel> create_source(SourceModel source) async {
    try {
      var resp = await dio.post("/auth/create_source", data: source.toJson());
      return SourceModel.fromJson(resp.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SourceModel> update_source(SourceModel source) async {
    try {
      var resp = await dio.post("/auth/update_source", data: source.toJson());
      return SourceModel.fromJson(resp.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SourceModel> delete_source(SourceModel source) async {
    try {
      var resp = await dio.post("/auth/delete_source", data: source.toJson());
      return SourceModel.fromJson(resp.data);
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<DirectoryModel>> auth_list_dirs(String path, String authId) async {
    try {
      var resp = await dio.get("/auth/auth_list_dirs", queryParameters: {"path": path,"auth_id":authId});
      List<DirectoryModel> dirs = [];
      for (var dir in resp.data) {
        dirs.add(DirectoryModel.fromJson(dir));
      }
      return dirs;
    } on DioError catch (e) {
      print(e);
      rethrow;
    }
  }
}
