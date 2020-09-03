import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:connectivity/connectivity.dart";
import 'package:flutter_frame/file/IndexPage.dart';
import 'package:flutter_frame/routePage/first_page.dart';
import 'package:flutter_frame/routePage/index_page.dart';
import 'package:flutter_frame/routePage/second_page.dart';
import 'package:flutter_frame/routePage/third_page.dart';
import 'package:flutter_frame/services/local_authentication_service.dart';
import 'package:flutter_frame/services/service_locator.dart';
import 'package:flutter_frame/utils/http_base_util.dart';
import 'package:flutter_frame/utils/route.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';


void main() {
  _beforeStart();
 //  setupLocator();
  runApp(MyApp2());
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //EdgeInsets 边缘插图 [e]
        //mainAxisSize: MainAxisSize.min, [i,i,a] 主轴尺寸
        //        mainAxisAlignment: MainAxisAlignment.center,  主轴对准
//        cross 交叉轴（从轴）
        // encode 编码 -》 String  ;  decode 解码 -》 bean Map
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        brightness: Brightness.light, //
        primaryColor: Colors.lightBlue,
        accentColor: Colors.lightBlue,
        buttonColor: Colors.orange,
        bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.green),
        // buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
        textTheme: TextTheme(title: TextStyle(color: Colors.blueAccent)),
        appBarTheme: AppBarTheme(
          color: Colors.greenAccent,
          textTheme: TextTheme( //EdgeInsets
            title: new TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      ),
      routes: {
        '/index': (BuildContext context) => IndexPage(),
        '/FirstPage': (BuildContext context) => FirstPage(),
        '/SecondPage': (BuildContext context) => SecondPage(),
        '/ThridPage': (BuildContext context) => ThridPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ThemeData Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {

            /*Map map = new Map();
            map["aa"] = "a";
            // 发送请求
           BaseResponse baseResponse  = await HttpBaseUtil().request(context, url: "http://baidu.com" ,method: RequestMethod.get);
           if(baseResponse.success == true ){
             print("aaaaaaaaaaaaa "+ baseResponse.res.toString());
             // 成功
           } else {
             // 失败
             print("aaaaaaaaaaaaa  error ");
           }
           var uuid = await FlutterGetuuid.platformUid;
           print("uuid "+ uuid);*/
          },
        ),
        body:  new Text("点击下方按钮可请求网络"),
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
        '/indexS': (BuildContext context) => IndexsPage(),
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
            RouteUtil.pushPage(context, IndexsPage());
          },
        ),
      ),
    );
  }

}

