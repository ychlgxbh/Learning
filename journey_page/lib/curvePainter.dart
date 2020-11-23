import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journey_page/curvePathInfo.dart';
import 'package:path_drawing/path_drawing.dart';

class CurvePainter extends CustomPainter {
  List<CurvePathInfo> generateCurveSegment(
    double startX,
    double startY,
    double width,
    double height,
    double numberOfSegments,
    bool direction,
    double weight,
  ) {
    List<CurvePathInfo> result = [];
    double currentX = startX;
    double currentY = startY;
    double nextX;
    double nextY;
    double referPointX;
    double referPointY;
    int dirCount = 0;

    for (int i = 0; i < numberOfSegments; i++) {
      // determing the coordinate of the destination
      nextX = direction ? currentX + 8 * width / 20 : currentX - 8 * width / 20;
      nextY = currentY + 1.5 * height / 20;

      //determing the coordinate of the reference point
      if (direction) {
        referPointX = currentX < 6 * width / 20
            ? currentX + 1 * width / 20
            : nextX - 1 * width / 20;

        referPointY = currentX < 6 * width / 20 ? nextY : currentY;
      } else {
        referPointX = currentX < 14 * width / 20
            ? nextX + 1 * width / 20
            : currentX - 1 * width / 20;
        referPointY = currentX < 14 * width / 20 ? currentY : nextY;
      }

      // store the info in an object
      CurvePathInfo temp = CurvePathInfo(
        currentX: currentX,
        currentY: currentY,
        destX: nextX,
        destY: nextY,
        refX: referPointX,
        refY: referPointY,
        direction: direction,
        curveWeight: weight,
      );
      print(temp.destX.toString());
      print(temp.destY.toString());
      print(temp.refX.toString());
      print(temp.refY.toString());
      //change the coordinate of current point to prepare for the next round
      currentX = nextX;
      currentY = nextY;
      result.add(temp);
      dirCount++;
      if (dirCount == 2) {
        direction = !direction;
        dirCount = 0;
      }
    }

    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 15.0;
    final _width = size.width;
    final _height = size.height;
    final double _conicWeight = 1.5;
    var curveSegmentInfo = generateCurveSegment(2 * _width / 20,
        1 * _height / 20, _width, _height, 8, true, _conicWeight);

    var path = Path();
    var lastPath = Path();
    path.moveTo(2 * _width / 20, 1 * _height / 20);
    // print(size.height.toString());
    // print(size.width.toString());
    // one 'S' shape(hardcode)
    // path.conicTo(3 * _width / 20, 3 * _height / 20, 10 * _width / 20,
    //     3 * _height / 20, _conicWeight);
    // path.conicTo(17 * _width / 20, 3 * _height / 20, 18 * _width / 20,
    //     5 * _height / 20, _conicWeight);

    for (int i = 0; i < curveSegmentInfo.length; i++) {
      if (i == curveSegmentInfo.length - 1) {
        lastPath.moveTo(
          curveSegmentInfo[i - 1].destX,
          curveSegmentInfo[i - 1].destY,
        );
        lastPath.conicTo(
          curveSegmentInfo[i].refX,
          curveSegmentInfo[i].refY,
          curveSegmentInfo[i].destX,
          curveSegmentInfo[i].destY,
          curveSegmentInfo[i].curveWeight,
        );
        break;
      }
      path.conicTo(
        curveSegmentInfo[i].refX,
        curveSegmentInfo[i].refY,
        curveSegmentInfo[i].destX,
        curveSegmentInfo[i].destY,
        curveSegmentInfo[i].curveWeight,
      );
    }

    // path.conicTo(56, 117, 205, 117, 1.5);
    // path.conicTo(354, 117, 375, 195, 1.5);
    canvas.drawPath(path, paint);
    canvas.drawPath(
      dashPath(
        lastPath,
        dashArray: CircularIntervalList<double>([15.0, 10.5]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;
}
