import 'package:flutter/material.dart';
import 'package:journey_page/iconPosition.dart';

class FlowCurveDelegate extends FlowDelegate {
  final Animation<double> curveAnimation;
  final List<IconPosition> iconPosition;

  FlowCurveDelegate(this.iconPosition, {this.curveAnimation}) : super(repaint: curveAnimation);

  @override
  bool shouldRepaint(FlowCurveDelegate oldDelegate) {
    return curveAnimation != oldDelegate.curveAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    print('context size');
    print(context.size.width);
    print(context.size.height);
    final width = context.size.width;
    final height = context.size.height;
    for (int i = 0; i < 10; i++) {
      
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          
          iconPosition[i].x,
          iconPosition[i].y,
          0,
        ),
      );
    }
  }
}
