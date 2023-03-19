import 'package:ceee_manager/core/Consts.dart';
import 'package:ceee_manager/model/AlbumModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/page/manager/source_album_manager_remote_page.dart';
import 'package:ceee_manager/util/data_store.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/widge_util.dart';

/// 分享页面
class SourceAlbumsManagerPage extends StatefulWidget {
  SourceModel sourceModel;
  String shareLink = "---";

  SourceAlbumsManagerPage(this.sourceModel, {Key? key}) : super(key: key) {
    shareLink =
        "${SpUtil.getString(StoreKey.BASE_URL.name)}/api/source/${sourceModel.id!}?pwd=${sourceModel.password}";
  }

  @override
  State<SourceAlbumsManagerPage> createState() => _SourceAlbumsManagerPageState();
}

class _SourceAlbumsManagerPageState extends State<SourceAlbumsManagerPage> {
  late List<AlbumModel> albums;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.sourceModel.name!),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: Text("分享"),
                        content: SelectableText.rich(
                            TextSpan(text: widget.shareLink, style: TextStyle(color: Colors.red))),
                        actions: [
                          CupertinoDialogAction(
                              child: Text("复制"),
                              onPressed: () {
                                //TODO copy to mem
                                Clipboard.setData(ClipboardData(text: widget.shareLink));
                                WidgetUtil.showToast(context, "复制成功");
                                Navigator.pop(context, "copy");
                              }),
                          CupertinoDialogAction(
                              child: Text("取消"),
                              onPressed: () {
                                //TODO copy to mem
                                Navigator.pop(context, "cancel");
                              }),
                        ],
                      ));
            },
            child: Icon(Icons.share_sharp),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => WidgetUtil.pushNavigator(
                context, SourceAlbumRemoteManager(widget.sourceModel, albums)),
            child: Icon(Icons.add_to_drive_outlined),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: FutureBuilder(
          future: HttpDio.get_albums(widget.sourceModel),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return WidgetUtil.getFutureBuilderErrorPage(context, setState);
            }
            if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
              albums = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.blueAccent,
                        ),
                        title: Text(albums[index].name!),
                        trailing: Icon(Icons.settings_sharp),
                        onTap: () {
                          var album = albums[index];
                          WidgetUtil.showMyDialog(
                              context,
                              SimpleDialog(
                                title: Text("${album.name}"),
                                children: [
                                  ListTile(
                                    title: Text("可否搜索"),
                                    trailing: CupertinoSwitch(
                                        value: album.enableSearch == 0,
                                        onChanged: (swich) {
                                          if (swich) {
                                            album.enableSearch = 0;
                                          } else {
                                            album.enableSearch = 1;
                                          }
                                          Navigator.maybePop(context);
                                          HttpDio.create_or_update_album(album)
                                              .then((value) => {
                                                    setState(() {
                                                      WidgetUtil.showToast(context, "修改成功");
                                                    })
                                                  })
                                              .onError((error, stackTrace) =>
                                                  {WidgetUtil.showToast(context, "添加失败")});
                                        }),
                                  ),
                                  Divider(
                                    height: 5,
                                  ),
                                  ListTile(
                                      title: ElevatedButton(
                                    child: Text("删除"),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                                    onPressed: () {
                                      Navigator.maybePop(context);
                                      HttpDio.delete_album(albums[index])
                                          .then((value) => {
                                                setState(() {
                                                  WidgetUtil.showToast(context, "已经删除");
                                                })
                                              })
                                          .catchError((error, stackTrace) {
                                        WidgetUtil.showToast(context, "删除失败");
                                      });
                                    },
                                  ))
                                ],
                              ));
                        },
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
