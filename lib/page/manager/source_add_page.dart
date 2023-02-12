import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

enum FileType { audio, epub }
class SourceAddPage extends StatefulWidget {
  void Function() callback;

  SourceAddPage(this.callback, {Key? key}) : super(key: key);

  @override
  State<SourceAddPage> createState() => _SourceAddPageState();
}

class _SourceAddPageState extends State<SourceAddPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _coverController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  late AuthModel _authModel;

  late String _apiVersion = "v1";

  List<AuthModel> auths = [];

  String? coverUrl;

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

  FileType fileType = FileType.audio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加源"),
      ),
      body: SingleChildScrollView(child: Form(
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
              decoration: const InputDecoration(labelText: "数据源", icon: Icon(Icons.source)),
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
                    labelText: "API 版本", icon: Icon(Icons.domain_verification_outlined)),
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
            TextFormField(
              controller: _coverController,
              decoration:
                  const InputDecoration(labelText: "封面 URL", hintText: "封面 URL", icon: Icon(Icons.image)),
              onChanged: (value) {
                setState(() {
                  coverUrl = value;
                });
              },
              // obscureText: true,
              //校验密码
              // validator: (v) {
              //   return v!.trim().length <= 4 ? null : "密码不能大于4位";
              // },
            ),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "类型",
                  hintText: "类型",
                  icon: Icon(Icons.file_present_outlined),
                ),
                items: const [
                  DropdownMenuItem(
                    child: Text("音频"),
                    value: FileType.audio,
                  ),
                  DropdownMenuItem(
                    child: Text("书籍"),
                    value: FileType.epub,
                  )
                ],
                onChanged: (v) {
                  fileType =v!;
                }),
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
                        if ((_formKey.currentState as FormState).validate()) {
                          var source = SourceModel(
                              name: _unameController.text,
                              authId: _authModel.id,
                              sourceType: _authModel.type,
                              apiVersion: _apiVersion,
                              password: _pwdController.text,
                              cover: _coverController.text,
                              fileType: fileType.name,
                              status: 1);

                          HttpDio.create_source(source).then((value) {
                            Navigator.pop(context);
                            widget.callback();
                          }).catchError((error, stackTrace) =>
                              WidgetUtil.showToast(context, "create source Error"));
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
      ),),
    );
  }


  // StatelessWidget getCoverImage() {
  //   try {
  //     return coverUrl == null ? Icon(Icons.image) : ImageIcon(Image.network(coverUrl! ,errorBuilder: (_,__,___){
  //       return Icon(Icons.image);
  //     },).image);
  //   } catch (e) {
  //     return Icon(Icons.image);
  //   }
  // }
}
