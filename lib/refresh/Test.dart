import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefreshList extends StatefulWidget {
  RefreshList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListViewState createState() => _ListViewState();
}
class _ListViewState extends State<RefreshList> {
  ScrollController  _controller;
  @override
  void initState(){
    super.initState();
    //初始化数据
    initData();
    //滑动监听
    _controller  =  new ScrollController();
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        //滑到底部了
        print("aaaaaaaaaaaa 滑动");
         _onGetMoreData();
      }
    });
  }

  //延迟3秒后刷新
  Future initData() async{
    setState(() {
      //用生成器给所有元素赋初始值
      list = List.generate(40, (i){
        return i;
      });
    });
  }
  /* const RefreshIndicator({
    Key key,
    @required this.child,
    this.displacement = 40.0,//下拉刷新的距离
    @required this.onRefresh,//下拉刷新回调方法
    this.color,              //进度指示器前景色 默认是系统主题色
    this.backgroundColor,    //背景色
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,     //小部件的标签
    this.semanticsValue,     //加载进度
  })*/
  bool isfresh = false;
  List list = new List();
  //下拉刷新回调方法
  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 3),(){
      setState(() {
        //数据清空再重新添加8条数据
        list.clear();
        list.addAll(List.generate(50, (i){
          return i;
        }));
      });
    });
  }
  Widget _itemColumn(BuildContext context,int index){
    if(index <list.length){
      return  Column(
        children: <Widget>[
          new Text("Text"+ list[index].toString()),
        ],
      );

    }
  }
   Future<Null> _onGetMoreData() async{
    await Future.delayed(Duration(seconds: 1),(){
      print('进入上拉加载方法');
      setState(() {
        //数据清空再重新添加8条数据
        //list.clear();
        list.addAll(List.generate(8, (i){
          return "add "+ i.toString();
        }));
        print("list "+ list.toString());
      });
    });
  }
  //是否隐藏底部
  bool isBottomShow = false;
  //加载状态
  String statusShow = '加载中...';
//上拉加载更多方法
 /* Future _onGetMoreData() async {
    print('进入上拉加载方法');
    isBottomShow = false;
    isfresh = false;
    if (list.length <= 400) {
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          //加载数据
          //这里添加8项
          list.addAll(List.generate(8, (i) {
            return i;
          }));
        });
      });
    } else {
      //假设已经没有数据了
      await Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isBottomShow = true;
        });
      });
    }

//显示'加载更多'，显示在界面上
    Widget _GetMoreDataWidget() {
      return Center(
        child: Padding(
            padding: EdgeInsets.all(12.0),
            // Offstage就是实现加载后加载提示圆圈是否消失
            child: new Offstage(
              // widget 根据isBottomShow这个值来决定显示还是隐藏
              offstage: isBottomShow,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    //根据状态来显示什么
                      statusShow,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 16.0,
                      )
                  ),
                  //加载圆圈
                  CircularProgressIndicator(
                    strokeWidth: 2.0,
                  )
                ],
              ),
            )

        ),
      );
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: new TextStyle(color: Colors.white),),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: list.length+1,
          itemBuilder: _itemColumn,
            controller: _controller,
        ),
        onRefresh: _onRefresh,
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}