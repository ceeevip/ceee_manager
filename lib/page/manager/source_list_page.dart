import 'package:ceee_manager/page/manager/source_add_page.dart';
import 'package:ceee_manager/page/manager/source_album_manager_remote_page.dart';
import 'package:ceee_manager/page/manager/source_albums_manager_page.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/SourceModel.dart';
import '../../util/http_util.dart';

class ManagerResourcePage extends StatefulWidget {
  const ManagerResourcePage({Key? key}) : super(key: key);

  @override
  State<ManagerResourcePage> createState() => _ManagerResourcePageState();
}

class _ManagerResourcePageState extends State<ManagerResourcePage> {
  void callback() {
    setState(() {});
  }

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
                        WidgetUtil.pushNavigator(
                            context, SourceAddPage(callback));
                      },
                      child: Icon(Icons.add_circle_sharp),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
                body: sms == null
                    ? Center(child: Text("Error"))
                    : ListView.builder(
                        itemCount: sms.length,
                        itemBuilder: (context, index) {
                          return SourceTile(sms[index], (SourceModel sm) {
                            setState(() {
                              sms.remove(sm);
                            });
                          });
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

class SourceTile extends StatefulWidget {
  SourceModel sm;
  Null Function(SourceModel sm) deleteCall;

  SourceTile(this.sm, this.deleteCall, {Key? key}) : super(key: key);

  @override
  State<SourceTile> createState() => _SourceTileState();
}

class _SourceTileState extends State<SourceTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
        activeColor: Colors.blueAccent,
        value: widget.sm.status == 0,
        onChanged: (value) {
          print("${widget.sm.name} - ${value}");
          widget.sm.status = value ? 0 : 1;
          HttpDio.update_source(widget.sm).then((value) => {setState(() {})});
        },
      ),
      title: Text(widget.sm.name ?? "无",style: TextStyle(fontWeight: FontWeight.bold),),
      trailing:  const Icon(Icons.settings,color: Colors.blueAccent,),
      onTap: () => WidgetUtil.pushNavigator(context, SourceAlbumsManagerPage(widget.sm)),
      onLongPress: () {
        //
        showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                    title: Text("是否要删除源 ${widget.sm.name}?"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          child: Text("取消"),
                          onPressed: () => Navigator.pop(context, "cancel")),
                      CupertinoDialogAction(
                          child: Text("确定"),
                          onPressed: () {
                            HttpDio.delete_source(widget.sm)
                                .then((value) => {
                                      setState(() {
                                        widget.deleteCall(widget.sm);
                                        Navigator.pop(context, "yes");
                                      })
                                    })
                                .onError((error, stackTrace) =>
                                    {WidgetUtil.showToast(context, "删除失败")});
                          }),
                    ]));
      },
    );
  }
}
