import 'package:ceee_manager/model/AlbumModel.dart';
import 'package:ceee_manager/model/SourceModel.dart';
import 'package:ceee_manager/page/manager/source_album_manager_remote_page.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:flutter/material.dart';

import '../../util/widge_util.dart';

class SourceAlbumsManagerPage extends StatefulWidget {
  SourceModel sourceModel;

  SourceAlbumsManagerPage(this.sourceModel, {Key? key}) : super(key: key);

  @override
  State<SourceAlbumsManagerPage> createState() => _SourceAlbumsManagerPageState();
}

class _SourceAlbumsManagerPageState extends State<SourceAlbumsManagerPage> {
  late List<AlbumModel> albums;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sourceModel.name!),
        actions: [
          InkWell(
            onTap: (){
              print("分享");
            },
            child: Icon(Icons.share_outlined),
          ),
          SizedBox(width: 10,),
          InkWell(
            onTap: () => WidgetUtil.pushNavigator(context, SourceAlbumRemoteManager(widget.sourceModel,albums)),
            child: Icon(Icons.manage_accounts_outlined),
          ),SizedBox(width: 15,)
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
                        leading: const Icon(Icons.folder),
                        title: Text(albums[index].name!),
                        trailing: const Icon(Icons.delete_forever_outlined),
                        onTap: () {
                          // setState(() {
                          //   print(albums[index]);
                          // });
                        },
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
