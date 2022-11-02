import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/page/manager_auth_page.dart';
import 'package:ceee_manager/page/manager_resource_page.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({Key? key}) : super(key: key);

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.source_outlined),
            title: Text("源管理"),
            trailing: InkWell(
              child: Icon(Icons.arrow_right),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManagerResourcePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.source_outlined),
            title: Text("存储认证管理"),
            trailing: InkWell(
              child: Icon(Icons.arrow_right),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ManagerAuthPage()));
            },
          )
        ],
      ),
    );
  }
}
