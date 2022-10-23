

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


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

}