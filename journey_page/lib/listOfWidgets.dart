import 'package:flutter/material.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';

import 'curvePathInfo.dart';

class ListOfWidgets extends StatelessWidget {
  final List<DrawingPoint> drawingPoint;
  final double height;
  ListOfWidgets(this.drawingPoint, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height *5,
      child: Stack(
        children: drawingPoint
            .map(
              (e) => Positioned(
                left: e.currentX,
                top: e.currentY,
                child: IconWidget(e.index%3 == 0 ? 40 : 15),
              ),
            )
            .toList(),
      ),
    );
  }
}
