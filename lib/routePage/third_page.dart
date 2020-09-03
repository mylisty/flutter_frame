import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_frame/MyHomePage.dart';
import 'package:flutter_frame/file/IndexPage.dart';
import 'package:flutter_frame/routePage/first_page.dart';
import 'package:flutter_frame/routePage/index_page.dart';
import 'package:flutter_frame/utils/route.dart';

import '../Test.dart';

class ThridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ThridState();
  }

}
class ThridState extends State<ThridPage>{
  @override
  void initState() {
  }
  @override
  void dispose() {
    print("ThridState dispose ");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: RaisedButton(onPressed: () {
          // 正常
     /*     Navigator.push(context,new MaterialPageRoute(builder: (BuildContext context) {
            return FirstPage();
          })).then((Object value) {
            print("value "+ value.toString());
          });*/
     // 删除之前所有页面
          /*Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context){
            return  new IndexsPage();
          }), (Route<dynamic> route) => false);*/
          var test2 = new Test2();
          test2.id = 1;
          test2.name = "222";
         /* RouteUtil.closePage(context, test2.toJson());
          RouteUtil.popUntil(context, "/FirstPage");*/
          RouteUtil.pushPageLogIn( "/home");
         //RouteUtil.pushAndRemoveUntil(context, FirstPage(), "/index");
       /*    Navigator.of(context).pushAndRemoveUntil(newRoute, predicate)*/
//Calls pop repeatedly on the navigator that most tightly encloses the given context until the predicate returns true
       /*    Navigator.of(context).popUntil(new MaterialPageRoute(builder: (BuildContext context){
             return new FirstPage();
           }),result: (Object value) {

           });*/

//          removeRoute(BuildContext context, Route route) → void
//          Immediately remove route from the navigator that most tightly encloses the given context, and Route.dispose it. [...]
//          removeRouteBelow(BuildContext context, Route anchorRoute) → void
//          Immediately remove a route from the navigator that most tightly encloses the given context, and Route.dispose it. The route to be replaced is the one below the given anchorRoute. [...]
//          replace<T extends Object>(BuildContext context, { Route oldRoute, Route<T> newRoute }) → void
//          Replaces a route on the navigator that most tightly encloses the given context with a new route. [...]
        },
          child: Text("ThridPage"),
        ),
      ),
    );
  }

}