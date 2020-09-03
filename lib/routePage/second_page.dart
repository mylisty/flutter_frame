import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/utils/route.dart';
import '../Test.dart';
class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SecondState();
  }

}
class SecondState extends State<SecondPage>{
  @override
  void initState() {
  }
  @override
  void dispose() {
    print("SecondPage dispose ");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: RaisedButton(onPressed: () {
          RouteUtil.pushNamed(context, "/ThridPage",callBack: (value) {
            print("value2 " + value.toString());
            Test2 fromJson = new Test2().fromJson(value);
            print("value2 ${fromJson.name}");
          });
        },
          child: Text("SecondPage"),
        ),
      ),
    );
  }

}