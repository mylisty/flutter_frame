import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_frame/MyHomePage.dart';
import 'package:flutter_frame/file/IndexPage.dart';
import 'package:flutter_frame/routePage/second_page.dart';

class FirstPage extends StatefulWidget {
  String title;
  FirstPage({Key key, this.title = ''}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return new FirstState();
  }

}
class FirstState extends State<FirstPage>{
  @override
  void initState() {
    print("FirstState initState ");
  }
  @override
  void deactivate() {
    super.deactivate();
    print(" FirstState deactivate");
  }
  @override
  void dispose() {
    print("FirstState dispose ");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String tmp = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      body: new Center(
        child: RaisedButton(onPressed: () {
          Navigator.of(context).pushNamed("/SecondPage").then((value) {
            print("value1  "+ value.toString());
          });
       /*   Navigator.push(context,new MaterialPageRoute(builder: (BuildContext context) {
            return SecondPage();
          })).then((Object value) {
            print("value 2"+ value.toString());
          });*/
        },
          child: Text("firstPage"+ widget.title),
        ),
      ),
    );
  }

}