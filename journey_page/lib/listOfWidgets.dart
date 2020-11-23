import 'package:flutter/material.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';

import 'curvePathInfo.dart';

class ListOfWidgets extends StatelessWidget {
  final List<DrawingPoint> drawingPoint;
  ListOfWidgets(this.drawingPoint);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: drawingPoint
            .map(
              (e) => Transform(
                transform: Matrix4.translationValues(e.currentX, e.currentY/20, 0),
                child: IconWidget(),
              ),
            )
            .toList(),  
      ),
    );
  }
}
