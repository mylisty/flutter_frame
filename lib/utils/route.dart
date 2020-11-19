import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circle_page_route.dart';

class RouteUtil {
  //全局key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 无法返回上一界面
  static pushSinglePage(BuildContext context, Widget page) {
    if (context == null || page == null) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => page),
        (Route<dynamic> route) => false);
  }
  /// // RouteSettings(
  //    arguments: bean  ,
  //  ),
  //  )
  //  下一个页面获取    final Bean bean   = ModalRoute.of(context).settings.arguments;
  static void pushPage(
    BuildContext context,
    Widget page, {
    bool needLogin = false,
    bool shouldReplace = false,
    Function callBack,
    RouteSettings settings, // 可传递下一个页面数据
  }) {
    PageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) => page,settings: settings);
    if (context == null || page == null) return;
    if (shouldReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((data) {
        if (callBack != null) {
          callBack(data);
        }
      });
    } else {
      if (!needLogin) {
        Navigator.of(context).push(pageRoute).then((data) {
          if (callBack != null) {
            callBack(data);
          }
        });
      }
    }
  }

  // 删除之前所有页面
  static void pushAndRemoveUntil(
      BuildContext context, Widget page, String routeName) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      ModalRoute.withName(routeName),
    );
  }

  // 删除之前所有页面
  static void pushAndRemoveUntil2(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }), (Route<dynamic> route) => false);
  }

  /// 用法：用pushNamed 依次打开页面，最后用popUtil返回到指定页面，中间的页面就会被销毁。
  static void pushNamed(
    BuildContext context,
    String routeName, {
    Function callBack,
  }) {
    Navigator.of(context).pushNamed(routeName).then((value) {
      if(callBack!= null){
        callBack(value);
      }
    });
  }
  /// 返回指定页面 销毁中间页面
  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  //关闭当前页面
  static void closePage(BuildContext context,{dynamic data}) {
    if(data != null){
      Navigator.of(context).pop(data);
    }else{
      Navigator.of(context).pop();
    }
  }

  //判断当前页面能否进行pop操作，并返回bool值
  //当栈中只有一个元素时 返回false
  static bool isCanPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  //无context跳转页面
  static void pushPageWithNoContext(String routeName) {
    RouteUtil.navigatorKey.currentState.pushNamed(routeName);
  }
  //无context跳转页面
  static void pushPageLogIn(String routeName) {
    RouteUtil.navigatorKey.currentState.pushNamedAndRemoveUntil(routeName,
        ModalRoute.withName("/"));
  }
  ///圆形方式打开页面
  ///[context]当前页面的Context
  ///[page]将要打开的页面
  ///[openOffset]打开页面的显示中心
  static pushPageAboutCircle(BuildContext context, Widget page,
      {Offset openOffset, GlobalKey key}) {
    /// MODIFIED: 2020/9/22 15:40 kennen  iOS使用默认动画，否则跳转进入登录页面无法返回
    if (Platform.isIOS) {
      pushPage(context, page);
    } else {
      Navigator.of(context).push(CirclePageRoute(
          context: context,
          centerOffset: openOffset,
          key: key,
          builder: (context) {
            return page;
          }));
    }
  }
}

