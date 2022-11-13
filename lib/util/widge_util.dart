

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:fluttericon/fontelico_icons.dart';

class WidgetUtil{

  // static void showBottomSheet(BuildContext context,MusicSummary musicSummary) {
  //   //用于在底部打开弹框的效果
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.transparent, //
  //       builder: (_) {
  //         return StatefulBuilder(builder: (context, state) {
  //           state((){});
  //           return AlbumMusicList(musicSummary: musicSummary);
  //         });
  //       });
  // }

  static void showToast(BuildContext context,String msg){
    ToastContext().init(context);
    Toast.show(msg, duration: Toast.lengthShort, gravity:  Toast.bottom);
  }

  static pushNavigator(BuildContext context, Widget widget){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return widget;
    }));
  }

  static Scaffold getFutureBuilderErrorPage(
      BuildContext context, void Function(VoidCallback fn) setState) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const BackButton(),
              const SizedBox(height: 100,),
              const Icon(Fontelico.emo_unhappy,size: 100,color: Colors.redAccent,),
              const SizedBox(height: 150,),
              TextButton(onPressed: (){
                setState(() {
                  print("刷新重试");
                });
              }, child: Text("点击重试")),
            ],
          )),
    );
  }

}