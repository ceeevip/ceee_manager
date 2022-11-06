import 'package:ceee_manager/page/manager/source_add_page.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

import '../../model/SourceModel.dart';
import '../../util/http_util.dart';

class ManagerResourcePage extends StatefulWidget {
  const ManagerResourcePage({Key? key}) : super(key: key);

  @override
  State<ManagerResourcePage> createState() => _ManagerResourcePageState();
}

class _ManagerResourcePageState extends State<ManagerResourcePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpDio.sources_list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<SourceModel>? sms = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text("源管理"),
                  actions: [
                    InkWell(
                      onTap: () {
                        WidgetUtil.pushNavigator(context, const SourceAddPage());
                      },
                      child: Icon(Icons.add),
                    ),
                    const SizedBox(
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
