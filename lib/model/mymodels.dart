
class LoginResponseEntity{
  bool status=false;
  String? msg ;
  String? refreshToken;
  String? accessToken;
  String? tokenType;

  LoginResponseEntity(this.status, {this.msg,this.accessToken, this.refreshToken,this.tokenType});

}