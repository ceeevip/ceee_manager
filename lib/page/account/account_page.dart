import 'package:ceee_manager/model/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/Consts.dart';
import '../../util/data_store.dart';

class AccountPage extends StatefulWidget {
  Function() loginoutCallback;

  AccountPage(Function() this.loginoutCallback, {Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserInfo userInfo ;

  @override
  void initState() {
setState(() {
  userInfo = UserInfo.fromJson(SpUtil.getObject(StoreKey.UERINFO.name));
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                      title: const Text(
                    "用户信息",
                  )),
                );
              }));
            },
            child: Icon(Icons.account_circle),
          )
        ],
      ),
      body: Column(
        children: [
          Text("服务器地址：" + SpUtil.getString(StoreKey.BASE_URL.name)!),
          Text("用户：${userInfo?.name}"  ),

          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child:
              ElevatedButton(
                child: Text("退出"),
                onPressed: () {
                  SpUtil.remove(StoreKey.ACCESS_TOKEN.name);
                  widget.loginoutCallback();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              )),
            ],
          )
        ],
      ),
    );
  }
}
