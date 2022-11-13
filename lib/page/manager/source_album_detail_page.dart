import 'package:ceee_manager/model/DirectoryModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/widge_util.dart';
import 'package:flutter/material.dart';

class SourceAlbumDetail extends StatefulWidget {
  SourceModel sourceModel;

  SourceAlbumDetail(this.sourceModel, {Key? key}) : super(key: key);

  @override
  State<SourceAlbumDetail> createState() => _SourceAlbumDetailState();
}

class _SourceAlbumDetailState extends State<SourceAlbumDetail> {
  List<String> currentPaths = ["/"];

  List<DirectoryModel> currentPathFiles = [];

  @override
  void initState() {
    // loadDirs(currentPath);
    super.initState();
  }

  // void loadDirs(String path) {
  //   HttpDio.auth_list_dirs(path, widget.sourceModel.authId!).then((dirs) {
  //     setState(() {
  //       currentPathFiles.clear();
  //       currentPathFiles.addAll(dirs);
  //     });
  //   });
  // }
  String pathname(String path){
    int index  = path.lastIndexOf("/");
    if(index ==-1 || path.length==1){
      return "/";
    }
    return path.substring(index+1);
  }

  List<Widget> getPathWidget() {
    List<Widget> textButtons = [SizedBox(width: 35 ,)];

    for (var p in currentPaths) {
      textButtons.add(TextButton(
          onPressed: () {
            //TODO click to geven path
            setState(() {
              currentPaths.removeRange(currentPaths.indexOf(p)+1, currentPaths.length);
            });
          },
          child: Text(pathname(p),style: TextStyle(color: Colors.red),)));
      textButtons.add(Text("/",));
    }
    textButtons.removeLast();
    textButtons.add(Spacer());
    return   textButtons;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: getPathWidget(),

        ),
        body: FutureBuilder(
            future: HttpDio.auth_list_dirs(
                currentPaths.last, widget.sourceModel.authId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return WidgetUtil.getFutureBuilderErrorPage(context, setState);
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                currentPathFiles.clear();
                currentPathFiles.addAll(snapshot.data ?? []);

                return ListView.builder(
                    itemCount: currentPathFiles.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: const Icon(Icons.folder),
                          title: Text(currentPathFiles[index].path!),
                          trailing: const Icon(Icons.keyboard_arrow_right),
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
