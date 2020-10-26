import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshPage extends StatefulWidget {
  RefreshPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new _RefreshPageState();
  }
}

class _RefreshPageState extends State<RefreshPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  List<String> items2 = [
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
  ];
  GlobalKey anchorKey = GlobalKey();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _scrollController = new ScrollController();
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext c, int b) {
            return ListView.builder(
              shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
              physics: NeverScrollableScrollPhysics(), //禁用滑动事件
              itemBuilder: (BuildContext context, int i) {
                Widget card = Card(child: Center(child: Text(items2[i])));
                return i == 0
                    ? Column(
                  children: <Widget>[
                    Container(
                      key: anchorKey,
                      color: Colors.cyan,
                      height: 50,
                      child: Text(items[b]),
                    ),
                    card,
                  ],
                )
                    : card;
              },
              itemExtent: 100.0,
              itemCount: items2.length,
            );
          },
          itemCount: items.length,

        ),
      ),
    );
  }
}
