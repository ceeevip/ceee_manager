import 'package:ceee_manager/page/manager/auth_add_page.dart';
import 'package:flutter/material.dart';

import '../../model/AuthModel.dart';
import '../../util/http_util.dart';

class ManagerAuthPage extends StatefulWidget {
  const ManagerAuthPage({Key? key}) : super(key: key);

  @override
  State<ManagerAuthPage> createState() => _ManagerAuthPageState();
}

class _ManagerAuthPageState extends State<ManagerAuthPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpDio.auths_list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<AuthModel>? sms = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text("资源管理"),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AuthAddPage(() {
                            setState(() {
                            });
                          });
                        }));
                      },
                      child: Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                body: sms == null
                    ? Center(child: Text("Error"))
                    : ListView.builder(
                        itemCount: sms.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.source),
                            title: Text(sms[index].name ?? "无"),
                          );
                        },
                      ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
