import 'package:ceee_manager/model/AuthModel.dart';
import 'package:flutter/material.dart';

import '../../util/http_util.dart';
import '../../util/widge_util.dart';

class AuthAddPage extends StatefulWidget {
  void Function() callback;

  AuthAddPage(this.callback, {Key? key}) : super(key: key);

  @override
  State<AuthAddPage> createState() => _AuthAddPageState();
}

class _AuthAddPageState extends State<AuthAddPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController(text: 'local');
  final TextEditingController _avatarUrlController = TextEditingController();
  final TextEditingController _aliasNameController = TextEditingController();
  final TextEditingController _initPathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("源权限添加"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
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
                TextFormField(
                  autofocus: true,
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: "类型",
                    hintText: "类型",
                    icon: Icon(Icons.abc_outlined),
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "不能为空";
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _avatarUrlController,
                  decoration: const InputDecoration(
                    labelText: "图像地址",
                    hintText: "图像地址",
                    icon: Icon(Icons.abc_outlined),
                  ),
                  validator: (v) {
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _aliasNameController,
                  decoration: const InputDecoration(
                    labelText: "别称",
                    hintText: "别称",
                    icon: Icon(Icons.abc_outlined),
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "别称不能为空";
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _initPathController,
                  decoration: const InputDecoration(
                    labelText: "初始化根目录",
                    hintText: "初始化根目录",
                    icon: Icon(Icons.abc_outlined),
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : "初始化目录不能为空";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("确定"),
                          ),
                          onPressed: () async {
                            // 通过_formKey.currentState 获取FormState后，
                            // 调用validate()方法校验用户名密码是否合法，校验
                            // 通过后再提交数据。
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              var source = AuthModel(
                                  name: _unameController.text,
                                  type: _typeController.text,
                                  avatarUrl: _avatarUrlController.text,
                                  aliasName: _aliasNameController.text,
                                  initPath: _initPathController.text);

                              HttpDio.create_auth(source).then((value) {
                                Navigator.pop(context);
                                WidgetUtil.showToast(context, "添加成功");
                                widget.callback();
                              }).catchError((error, stackTrace) =>
                                  WidgetUtil.showToast(
                                      context, "create source Error"));
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
            )),
      ),
    );
  }
}
