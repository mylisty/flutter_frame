import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/materialApp/materal.dart';
import 'package:flutter_frame/routePage/index_page.dart';
import 'package:flutter_frame/utils/http_base_util.dart';


class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SpalshState();
  }

}
class SpalshState extends State<SplashPage>{
  Timer _timer ;
  int _count = 1;
  @override
  void initState() {
 /*   Map map = new Map();
    map["a"] = "a";
    HttpBaseUtil().request(context, url: "aaa",data: map,method: RequestMethod.put);*/
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
    if(_timer == null) {
      _timer = new Timer.periodic(new Duration(seconds: 1), (timers){
          _count = _count-1;
          print("count "+ _count.toString());
         if(0 ==_count){
           _timer?.cancel();
           _timer = null;
           Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context){
             return  new MaterialPage();
           }), (Route<dynamic> route) => false);
         }
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Image.asset('assets/images/splash.png',fit: BoxFit.fill,)
      ),
    );
  }

}