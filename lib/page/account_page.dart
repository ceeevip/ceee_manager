import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/Consts.dart';
import '../util/data_store.dart';

class AccountPage extends StatefulWidget {
  Function() loginoutCallback;

  AccountPage(Function() this.loginoutCallback, {Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    // TODO: implement initState
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
                      title: Text(
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
