import 'package:ceee_manager/page/manager/auth_list_page.dart';
import 'package:flutter/material.dart';

import 'source_list_page.dart';

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
            leading: Icon(Icons.water_drop_sharp,color: Colors.redAccent,),
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
            leading: Icon(Icons.source_sharp,color: Colors.redAccent),
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
