import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SourceAddPage extends StatefulWidget {
  const SourceAddPage({Key? key}) : super(key: key);

  @override
  State<SourceAddPage> createState() => _SourceAddPageState();
}

class _SourceAddPageState extends State<SourceAddPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  late String authId ;
  late String apiVersion = "v1";

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
                decoration:
                    InputDecoration(labelText: "数据源", icon: Icon(Icons.source)),
                items: const [
                  DropdownMenuItem(
                    child: Text("xxx"),
                    value: "11",
                  ),
                  DropdownMenuItem(
                    child: Text("yyy"),
                    value: "22",
                  ),
                  DropdownMenuItem(
                    child: Text("zzz"),
                    value: "33",
                  )
                ],
                onChanged: (value) {
                  authId = value!;
                }),
            DropdownButtonFormField(
                decoration:
                InputDecoration(labelText: "API 版本", icon: Icon(Icons.domain_verification_outlined)),
                items: const [
                  DropdownMenuItem(
                    child: Text("v1"),
                    value: "v1",
                  )

                ],
                onChanged: (value) {
                  authId = value!;
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
                      onPressed: () {
                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        if ((_formKey.currentState as FormState).validate()) {
                          print("提交数据");
                        }else{
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
