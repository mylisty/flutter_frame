import 'package:flutter/cupertino.dart';

import 'circle_path.dart';


class CirclePageRoute extends PageRoute {

  CirclePageRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    this.context,
    this.centerOffset,
    GlobalKey key,
  }){
    if(key!=null&&key.currentContext!=null&&key.currentContext.findRenderObject()!=null){

      //获取position
      RenderBox renderBox = key.currentContext.findRenderObject();
      ///获取 Offset
      Offset offset1 = renderBox.localToGlobal(Offset.zero);
      ///获取 Size
      //获取size
      Size size1 = renderBox.size;
      centerOffset = offset1;
    }
  }

  BuildContext context;
  Offset centerOffset;
  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CirclePath(animation.value,centerOffset:centerOffset),
          child: child,
        );
      },
      child: builder(context),
    );
  }
}