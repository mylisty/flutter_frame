import 'package:flutter/material.dart';


class MaterialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MaterialState();
  }

}
class _MaterialState extends State<MaterialPage>{
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("MateralApp"),
      ),
      body: RaisedButton(onPressed: () {
        
      },
        child: Text("aaaaaa"),
        textTheme: Theme.of(context).buttonTheme.textTheme,
      ),
    );
  }
}