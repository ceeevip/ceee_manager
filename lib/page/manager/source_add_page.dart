import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SourceAddPage extends StatefulWidget {
  void Function() callback;

  SourceAddPage(this.callback, {Key? key}) : super(key: key);

  @override
  State<SourceAddPage> createState() => _SourceAddPageState();
}

class _SourceAddPageState extends State<SourceAddPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  late AuthModel _authModel;

  late String _apiVersion = "v1";

  List<AuthModel> auths = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      HttpDio.auths_list().then((value) {
        setState(() {
          auths.addAll(value ?? []);
        });
      });
    }
  }

  List<DropdownMenuItem> getAuthsList() {
    List<DropdownMenuItem> items = [];
    for (var auth in auths) {
      items.add(DropdownMenuItem(child: Text(auth.name!), value: auth));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加源"),
      ),
      body: Form(
        key: _formKey, //设置globalKey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: const InputDecoration(
                labelText: "名称",
                hintText: "名称",
                icon: Icon(Icons.abc_outlined),
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "名称不能为空";
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "数据源", icon: Icon(Icons.source)),
              items: getAuthsList(),
              onChanged: (value) {
                _authModel = value!;
              },
              validator: (v) {
                return v != null ? null : "不能为空";
              },
            ),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                    labelText: "API 版本",
                    icon: Icon(Icons.domain_verification_outlined)),
                items: const [
                  DropdownMenuItem(
                    value: "v1",
                    child: Text("v1"),
                  )
                ],
                onChanged: (value) {
                  _apiVersion = value!;
                },
                validator: (v) {
                  return v != null ? null : "不能为空";
                }),
            TextFormField(
              controller: _pwdController,
              decoration: const InputDecoration(
                labelText: "验证密码",
                hintText: "验证密码",
                icon: Icon(Icons.lock),
              ),
              // obscureText: true,
              //校验密码
              validator: (v) {
                return v!.trim().length <= 4 ? null : "密码不能大于4位";
              },
            ),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("确定"),
                      ),
                      onPressed: () async {
                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        if ((_formKey.currentState as FormState).validate()) {
                          var source = SourceModel(
                              name: _unameController.text,
                              authId: _authModel.id,
                              sourceType: _authModel.type,
                              apiVersion: _apiVersion,
                              status: 1);
                          try {
                            HttpDio.create_source(source).then((value) {
                              Navigator.pop(context);
                              widget.callback();
                            });
                          } catch (e) {
                            WidgetUtil.showToast(
                                context, "create source Error:${e}");
                          }
                        } else {
                          print("失败不提交");
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
