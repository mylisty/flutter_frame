import 'package:flutter/material.dart';


class IndexsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new  IndexsState();
  }

}
class  IndexsState extends State<IndexsPage>{
  @override
  void initState() {
  }
  @override
  void dispose() {
    print("IndexPage dispose ");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  new Center(
        child: RaisedButton(onPressed: () {
          Navigator.of(context).pushNamed("/FirstPage",arguments: 'aaa').then((value){
            print("value " + value.toString());
          });
//         Navigator.push(context,new MaterialPageRoute(builder: (BuildContext context) {
//            return FirstPage();
//          })).then((Object value) {
//            print("value "+ value.toString());
//          });
        },
          child: Text("IndexPage"),
        ),
      ),
    );
  }

}