import 'package:flutter/material.dart';
import 'package:journey_page/curvePainter.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';

class JourneyBlock extends StatelessWidget {
  final double _bodyWidth;
  final double _bodyHeight;
  final int _numberOfSegment;
  JourneyBlock(this._bodyWidth, this._bodyHeight, this._numberOfSegment);

  @override
  Widget build(BuildContext context) {
    final List<DrawingPoint> _drawingPoint = new CurvePainter()
        .getDrawingPoints(_bodyWidth, _bodyHeight, _numberOfSegment);
    final listOfChildren = _drawingPoint
        .map(
          (e) => Positioned(
            left: e.currentX,
            top: e.currentY,
            child: IconWidget(e.index),
          ),
        )
        .toList();
    listOfChildren.insert(
      0,
      new Positioned(
        child: CustomPaint(
          painter: CurvePainter(),
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        ),
      ),
    );
    return Stack(
      children: listOfChildren,
    );
  }
}
