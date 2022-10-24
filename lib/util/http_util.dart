import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/model/mymodels.dart';
import 'package:dio/dio.dart';

class HttpDio {
  static Dio dio = Dio();

  static initOptions(String base_url,Map<String,dynamic> headers){
    dio.options.baseUrl = base_url;
    dio.options.headers.addAll(headers);
  }

  static Future<LoginResponseEntity> login_token(String base_url, String email, String pwd) async {

    try {
      var formData = FormData.fromMap({"username": email, "password": pwd});
      var response = await dio.post(
        "${base_url}/auth/token",
        options: Options(receiveDataWhenStatusError: true),
        data: formData,
      );
      return LoginResponseEntity(true, accessToken:response.data['access_token'],refreshToken:response.data['refresh_token'],tokenType:response.data['token_type']);
    } on DioError catch (e) {
      print(e.response);
      return LoginResponseEntity(false, msg: "${e.response}");

    }
  }

  static Future<List<SourceModel>?> sources_list() async{
    try {
      List<SourceModel> rs = [];
      var jsStr = await dio.get("/auth/list_source");
      for(var source in jsStr.data){
        rs.add(SourceModel.fromJson(source));
      }
      return rs;
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<List<AuthModel>?> auths_list() async{
    try {
      List<AuthModel> rs = [];
      var jsStr = await dio.get("/auth/list_auths");
      for(var source in jsStr.data){
        rs.add(AuthModel.fromJson(source));
      }
      return rs;
    } on DioError catch (e) {
      print(e);
    }
  }


}
