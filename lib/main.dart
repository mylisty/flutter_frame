import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:connectivity/connectivity.dart";
import 'package:flutter_frame/file/IndexPage.dart';
import 'package:flutter_frame/page/provider/provider.dart';
import 'package:flutter_frame/refresh/refreshList.dart';
import 'package:flutter_frame/refresh/refresh_page.dart';
import 'package:flutter_frame/routePage/first_page.dart';
import 'package:flutter_frame/routePage/index_page.dart';
import 'package:flutter_frame/routePage/second_page.dart';
import 'package:flutter_frame/routePage/third_page.dart';
import 'package:flutter_frame/utils/http_base_util.dart';
import 'package:flutter_frame/utils/route.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'page/provider/counter_model.dart';

void main() {
  _beforeStart();
  //  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: materialApp(),
  ));
}

MaterialApp materialApp() {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //EdgeInsets 边缘插图 [e]
      //mainAxisSize: MainAxisSize.min, [i,i,a] 主轴尺寸
      //        mainAxisAlignment: MainAxisAlignment.center,  主轴对准
//        cross 交叉轴（从轴）
      // encode 编码 -》 String  ;  decode 解码 -》 bean Map
      brightness: Brightness.light, // 夜晚和白天模式
      primaryColor: Colors.lightBlue,
      accentColor: Colors.red, // 辅助颜色 FloatingActionButton
      buttonColor: Colors.cyan, // button的背景颜色
      bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.green),
      // buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
      textTheme: TextTheme(title: TextStyle(color: Colors.blueAccent)),
      appBarTheme: AppBarTheme(
        color: Colors.cyan,
        textTheme: TextTheme(
          //EdgeInsets
          title: new TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    ),
    routes: {
      '/home': (BuildContext context) => MyHomePage(),
      '/index': (BuildContext context) => IndexPage(),
      '/FirstPage': (BuildContext context) => FirstPage(
            title: '',
          ),
      '/SecondPage': (BuildContext context) => SecondPage(),
      '/ThridPage': (BuildContext context) => ThridPage(),
    },
    localizationsDelegates: [
      // this line is important
      RefreshLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('zh'),
      const Locale('en'),
    ],
    localeResolutionCallback:
        (Locale locale, Iterable<Locale> supportedLocales) {
      //print("change language");
      return locale;
    },
    home: MyApp(),
  );
}

void _beforeStart() async {
  /// 检测网络状态
  WidgetsFlutterBinding.ensureInitialized();
  Connectivity connectivity = Connectivity();
  ConnectivityResult result = await connectivity.checkConnectivity();
  if (result == null || result == ConnectivityResult.none) {
    /// 没有网络，挂起所有网络请求
    /// 开启网络状态监听
    print("没有网络");
    connectivity.onConnectivityChanged.listen((changeResult) {
      if (changeResult == ConnectivityResult.mobile ||
          changeResult == ConnectivityResult.wifi) {
        /// 监听到网络可用，解锁所有网络请求
        print("changeReslut" + changeResult.toString());
      }
    });
  } else {
    print("有网路了");
  }
  print("before");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeData Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Map map = new Map();
          map["aa"] = "a";
          // 发送请求
          BaseResponse baseResponse = await HttpBaseUtil().request(context,
              url: "http://baidu.com", method: RequestMethod.get);
          if (baseResponse.success == true) {
            // 成功
            LogUtil.e("aaaaaaaaaaaaaaa 成功");
          } else {
            // 失败
          }
          var uuid = await FlutterGetuuid.platformUid;
          print("uuid " + uuid); // ffffffffe1e7b0aae1e7b0aa00000000 荣耀手机
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  // 刷新页面
//                  RouteUtil.pushPage(context, ProviderPageDemo());
                  RouteUtil.pushPageAboutCircle(context, new FirstPage(),key: globalKey);
                },
                child: Text("ListView"),
                key: globalKey,
              ),
            ],
          )
        ],
      ),
    );
  }

  var card = new SizedBox(
    height: 210.0,
    child: new Card(
      child: new Column(
        children: [
          new ListTile(
            title: new Text('1625 Main Street',
                style: new TextStyle(fontWeight: FontWeight.w500)),
            subtitle: new Text('My City, CA 99984'),
            leading: new Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          //   new Divider(),
          new ListTile(
            title: new Text('(408) 555-1212',
                style: new TextStyle(fontWeight: FontWeight.w500)),
            leading: new Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          new ListTile(
            title: new Text('costa@example.com'),
            leading: new Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteUtil.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (BuildContext context) => MyHomePage(),
        '/index': (BuildContext context) => IndexPage(),
        '/FirstPage': (BuildContext context) => FirstPage(
              title: '',
            ),
        '/SecondPage': (BuildContext context) => SecondPage(),
        '/ThridPage': (BuildContext context) => ThridPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/dancamdev.png'),
        ),
        title: Text('Local Authentication'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('authenticate'),
          onPressed: () async {
            RouteUtil.closePage(context);
            RouteUtil.pushPage(context, IndexsPage(),);
          },
        ),
      ),
    );
  }
}
