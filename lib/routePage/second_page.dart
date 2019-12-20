import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_frame/MyHomePage.dart';
import 'package:flutter_frame/file/IndexPage.dart';
import 'package:flutter_frame/routePage/third_page.dart';

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
     //     Navigator.of(context).pushNamed("/ThridPage");
          Navigator.of(context).pushNamed("/ThridPage").then((value) {
            print("value2 "+ value.toString());
            Navigator.of(context).pop(value.toString());
          });
         /* Navigator.push(context,new MaterialPageRoute(builder: (BuildContext context) {
            return ThridPage();
          })).then((Object value) {
            print("value "+ value.toString());
          });*/
        },
          child: Text("SecondPage"),
        ),
      ),
    );
  }

}