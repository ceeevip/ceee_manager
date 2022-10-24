import 'package:ceee_manager/model/AuthModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
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
                  builder: (context) => FutureBuilder(
                      future: HttpDio.sources_list(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<SourceModel>? sms = snapshot.data;
                          return Scaffold(
                            appBar: AppBar(title: Text("源管理"),),
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
                          return CircularProgressIndicator();
                        }
                      })));
            },
          ),
          ListTile(
            leading: Icon(Icons.source_outlined),
            title: Text("资源认证"),
            trailing: InkWell(
              child: Icon(Icons.arrow_right),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                      future: HttpDio.auths_list(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<AuthModel>? sms = snapshot.data;
                          return Scaffold(
                              appBar: AppBar(title: Text("资源管理"),),
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
                          return CircularProgressIndicator();
                        }
                      })));
            },
          )

        ],
      ),
    );
  }
}
