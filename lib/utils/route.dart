import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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



  static void pushPage(
      BuildContext context,
      Widget page, {
        bool needLogin = false,
        bool shouldReplace = false,
        Function callBack,
      }) {
    PageRoute pageRoute =
    MaterialPageRoute(builder: (BuildContext context) => page);
    if (context == null || page == null) return;
    if (shouldReplace) {
      Navigator.of(context).pushReplacement(pageRoute);
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
  static void pushAndRemoveUntil(BuildContext context,  Widget page,String routeName) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      ModalRoute.withName(routeName),
    );
  }
  //关闭当前页面
  static void closePage(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  //判断当前页面能否进行pop操作，并返回bool值
  //当栈中只有一个元素时 返回false
  static bool isCanPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }
}

/***
 *
 * 在Android中页面跳转使用context.startActivity
 * iOS中页面之间跳转使用的是ViewController
 *
 * Navigator用来管理堆栈功能（即push和pop）
 * 当我们导航到另一个屏幕时，我们使用Navigator.push方法将新屏幕添加到堆栈的顶部。当然，这些pop方法会从堆栈中删除该屏幕。
 *
 * Navigator.push(打开页面)
 * Navigator.pop(退出当前页面)
 *
 * 点击tabbar回退按钮或者android的返回按键, flutter会默认调取flutter.pop方法
 *
 * Navigator.of(context).pushNamedAndRemoveUntil(参数一，参数二) 指将制定的页面加入到路由中，然后将之前的路径移除知道制定的页面
 *
 * Navigator.of(context).maybePop(); maybePop 会自动进行判断，如果当前页面pop后，会显示其他页面，不会出现问题，则将执行当前页面的pop操作
 * Navigator.of(context).canPop() canPop  判断当前页面能否进行pop操作，并返回bool值
 */

/***
 * 带返回值的页面跳转：

    String userName = "yinll";
    Navigator.push(
    context,
    new MaterialPageRoute(
    builder: (BuildContext context) =>
    new Screen5(userName))).then((data){
    result =data;
    print(result);
    });

    然后screen5中，在返回时使用：Navigator.of(context).pop('这是页面5返回的参数');
    在pop中写上返回的的值，这时候在上方的then中即可得到返回的数据。
 */
