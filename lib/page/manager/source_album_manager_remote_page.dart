import 'package:ceee_manager/model/AlbumModel.dart';
import 'package:ceee_manager/model/DirectoryModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/theme_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

class SourceAlbumRemoteManager extends StatefulWidget {
  SourceModel sourceModel;
  List<AlbumModel> albums;

  late List<String> strAlbums = [];

  SourceAlbumRemoteManager(this.sourceModel, this.albums, {Key? key}) : super(key: key) {
    for (var value in albums) {
      strAlbums.add(value.path!);
    }
  }

  @override
  State<SourceAlbumRemoteManager> createState() => _SourceAlbumRemoteManagerState();
}

class _SourceAlbumRemoteManagerState extends State<SourceAlbumRemoteManager> {
  List<String> currentPaths = ["/"];

  List<DirectoryModel> currentPathFiles = [];

  @override
  void initState() {
    // loadDirs(currentPath);
    super.initState();
  }

  String pathname(String path) {
    int index = path.lastIndexOf("/");
    if (index == -1 || path.length == 1) {
      return "/";
    }
    return path.substring(index + 1);
  }

  List<Widget> getPathWidget() {
    List<Widget> textButtons = [];

    for (var p in currentPaths) {
      textButtons.add(TextButton(
          style: ButtonStyle(
              padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
                  EdgeInsets.only(left: 5, right: 5))),
          onPressed: () {
            //TODO click to geven path
            setState(() {
              currentPaths.removeRange(currentPaths.indexOf(p) + 1, currentPaths.length);
            });
          },
          child: Text(pathname(p))));
      if (p != "/") {
        textButtons.add(Container(
            // padding: EdgeInsets.only(top: 18.5),
            child: Text(
          "/",
          style: TextStyle(color: ThemeUtil.isDarkMode(context) ? Colors.white : Colors.black12),
        )));
      }
    }
    textButtons.removeLast();
    textButtons.add(Spacer());
    if (textButtons.length <= 5) {
      return textButtons;
    } else {
      var rs = textButtons.sublist(textButtons.length - 5);
      rs.insert(
          0,
          Text(
            "..",
            style: TextStyle(color: ThemeUtil.isDarkMode(context) ? Colors.white : Colors.black12),
          ));
      return rs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: getPathWidget(),
          ),
        ),
        body: FutureBuilder(
            future: HttpDio.auth_list_dirs(currentPaths.last, widget.sourceModel.authId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return WidgetUtil.getFutureBuilderErrorPage(context, setState);
              }
              if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                currentPathFiles.clear();
                currentPathFiles.addAll(snapshot.data ?? []);

                return ListView.builder(
                    itemCount: currentPathFiles.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: Icon(Icons.folder,color: widget.strAlbums.contains(currentPathFiles[index].path)?Colors.amber:null,),
                          title: Text(pathname(currentPathFiles[index].path!)),
                          trailing: Switch(
                            value: widget.strAlbums.contains(currentPathFiles[index].path),
                            onChanged: (value) {
                              print("${value}");
                              var thisFile = currentPathFiles[index];
                              if (value) {
                                //add
                                AlbumModel albumModel = AlbumModel(
                                  path: thisFile.path,
                                  fsId: thisFile.fsId,
                                  sourceId: widget.sourceModel.id,
                                  name: pathname(thisFile.path!),
                                );
                                HttpDio.create_album(albumModel).then((value) => {
                                      setState(() {
                                        widget.strAlbums.add(thisFile.path!);
                                      })
                                    }).onError((error, stackTrace) => {
                                  WidgetUtil.showToast(context, "添加失败")
                                });
                              } else {
                                //delete
                                HttpDio.delete_album(AlbumModel(path: thisFile.path))
                                    .then((value) => {
                                          setState(() {
                                            widget.strAlbums.remove(thisFile.path!);
                                          })
                                        }).onError((error, stackTrace) => {
                                          WidgetUtil.showToast(context, "删除失败")
                                });
                              }
                            },
                          ),
                          onTap: () {
                            setState(() {
                              currentPaths.add(currentPathFiles[index].path!);
                            });
                          },
                        ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

//
// class ListViewFuture extends StatefulWidget {
//   const ListViewFuture({Key? key}) : super(key: key);
//
//   @override
//   State<ListViewFuture> createState() => _ListViewFutureState();
// }
//
// class _ListViewFutureState extends State<ListViewFuture> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(builder: builder);
//   }
// }