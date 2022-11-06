import 'package:ceee_manager/core/Consts.dart';
import 'package:ceee_manager/model/mymodels.dart';
import 'package:ceee_manager/util/data_store.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  Function() loginSuccess;

  LoginPage(
    Function() this.loginSuccess, {
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var serverAddress = new TextEditingController(text: "http://localhost:8000");
  var email = new TextEditingController();
  var password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("登录"),
        ),
        body: Container(
            padding: const EdgeInsets.all(100),
            child: Column(
              children: [
                TextField(
                  controller: serverAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.computer_outlined),
                      hintText: "服务器地址如  http://127.0.0.1:8084",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: "Email",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
                      hintText: "密码",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: () {
                          HttpDio.login_token(serverAddress.text,
                              email.text, password.text).then((LoginResponseEntity result) {
                                if (result.status){
                                  SpUtil.putString(StoreKey.ACCESS_TOKEN.name, result.accessToken!);
                                  SpUtil.putString(StoreKey.REFRESH_TOKEN.name, result.refreshToken!);
                                  SpUtil.putString(StoreKey.BASE_URL.name, serverAddress.text);
                                  SpUtil.putString(StoreKey.TOKEN_TYPE.name, result.tokenType!);
                                  HttpDio.initOptions(serverAddress.text,{"Authorization":"${result.tokenType} ${result.accessToken}"});
                                  HttpDio.user_info().then((value) {
                                    SpUtil.putObject(StoreKey.UERINFO.name, value.toJson());
                                    widget.loginSuccess();
                                    WidgetUtil.showToast(context,"登录成功!");
                                  }).onError((error, stackTrace) {
                                  WidgetUtil.showToast(context,"登录 获取客户信息 失败!");
                                  });

                                }else{
                                  WidgetUtil.showToast(context, result.msg!);
                                }
                          });
                        },
                        child: const Text(
                          "登录",
                        )),
                    Spacer(),
                  ],
                )
              ],
            )));
  }
}
