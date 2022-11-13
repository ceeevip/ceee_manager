import 'package:ceee_manager/core/Consts.dart';
import 'package:ceee_manager/page/account/account_page.dart';
import 'package:ceee_manager/page/first_page.dart';
import 'package:ceee_manager/page/account/login_regist_page.dart';
import 'package:ceee_manager/page/manager/manager_page.dart';
import 'package:ceee_manager/util/data_store.dart';
import 'package:ceee_manager/util/http_util.dart';
import 'package:ceee_manager/util/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceee管理',
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeUtil.getThemeData(),
      darkTheme: ThemeUtil.getThemeData(isDarkMode: true),
      home: const MainAppWidget(),
    );
  }
}

class MainAppWidget extends StatefulWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  @override
  State<MainAppWidget> createState() => _MainAppWidgetState();
}

class _MainAppWidgetState extends State<MainAppWidget> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late List<BottomNavigationBarItem> _items;
  late List<Widget> _pages;
  var isLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoginSuccess = SpUtil.getString(StoreKey.ACCESS_TOKEN.name) != '';
      if (isLoginSuccess) {
        HttpDio.initOptions(SpUtil.getString(StoreKey.BASE_URL.name)!, {
          "Authorization":
              "${SpUtil.getString(StoreKey.TOKEN_TYPE.name)!} ${SpUtil.getString(StoreKey.ACCESS_TOKEN.name)!}"
        });
      }
    });
  }

  Widget getMainWidget() {
    _items = [
      const BottomNavigationBarItem(
          label: "首页", icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home)),
      const BottomNavigationBarItem(
          label: "管理", icon: Icon(Icons.list_outlined), activeIcon: Icon(Icons.list)),
      const BottomNavigationBarItem(
          label: "我的",
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle)),
    ];

    try {
      _pages = [
        FutureBuilder(
            future: SpUtil.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FirstPage();
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.amberAccent,
                ));
              }
            }),
        ManagerPage(),
        AccountPage(this.loginoutCallback)
      ];
    } catch (e, s) {
      print(s);
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        // selectedItemColor: Colors.redAccent,
        // unselectedItemColor: Colors.black45,
        items: _items,
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  // typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

  loginoutCallback() {
    setState(() {
      if (mounted) {
        setState(() {
          isLoginSuccess = SpUtil.getString(StoreKey.ACCESS_TOKEN.name) != "";
        });
      }
    });
  }

  Widget getLogin() {
    return LoginPage(loginoutCallback);
  }

  @override
  Widget build(BuildContext context) {
    return isLoginSuccess ? getMainWidget() : getLogin();
  }

  void _onPageChanged(int index) {
    // if (_currentPage != index) {
    print("to index ${index}");
    setState(() => _currentPage = index);
    // }
  }
}
