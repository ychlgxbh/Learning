import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journey_page/curvePathInfo.dart';
import 'package:journey_page/userInfo.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:path_drawing/path_drawing.dart';

class CurvePainter extends CustomPainter {
  final List<Dot> dotList;
  CurvePainter(this.dotList);
  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;
  // List<DrawingPoint> getDrawingPoints(
  //     double width, double height, int numberOfSegments) {
  //   var direction = true;

  //   var currentX = width / 30;
  //   var currentY = 0.0;
  //   double nextX;
  //   double nextY;
  //   int counter = 0;
  //   List<DrawingPoint> result = [];
  //   //print('width in get method: $width');
  //   //print('height in get method: $height');

  //   for (int i = 0; i < numberOfSegments; i++) {
  //     // determing the coordinate of the destination
  //     nextX = direction ? currentX + 8 * width / 20 : currentX - 8 * width / 20;
  //     nextY = currentY + 1.5 * height / 20;

  //     result.add(new DrawingPoint(currentX, currentY, result.length));
  //     if (direction) {
  //       if (counter == 0) {
  //         //points on the first curve segment
  //         result.add(new DrawingPoint(currentX + 8 * width / 20 / 3,
  //             currentY + 11 / 12 * 1.5 * height / 20, result.length));
  //         result.add(new DrawingPoint(currentX + 2 * 8 * width / 20 / 3,
  //             currentY + 12.5 / 12 * 1.5 * height / 20, result.length));
  //         counter++;
  //       } else {
  //         //points on the second curve segment
  //         result.add(new DrawingPoint(currentX + 8 * width / 20 / 3,
  //             currentY + 3 / 36 * 1.5 * height / 20, result.length));
  //         result.add(new DrawingPoint(currentX + 2 * 8 * width / 20 / 3,
  //             currentY + 5 / 24 * 1.5 * height / 20, result.length));
  //         direction = !direction;

  //         counter = 0;
  //       }
  //     } else {
  //       //points on the third curve segment
  //       if (counter == 0) {
  //         result.add(new DrawingPoint(currentX - 8 * width / 20 / 3,
  //             currentY + 9.5 / 12 * 1.5 * height / 20, result.length));
  //         result.add(new DrawingPoint(currentX - 2 * 8 * width / 20 / 3,
  //             currentY + 11.8 / 12 * 1.5 * height / 20, result.length));
  //         counter++;
  //       } else {
  //         //points on the fourth curve segment
  //         result.add(new DrawingPoint(currentX - 8 * width / 20 / 3,
  //             currentY + 1 / 24 * 1.5 * height / 20, result.length));
  //         result.add(new DrawingPoint(currentX - 2 * 8 * width / 20 / 3,
  //             currentY + 2 / 12 * 1.5 * height / 20, result.length));
  //         direction = !direction;
  //         counter = 0;
  //       }
  //     }
  //     currentX = nextX;
  //     currentY = nextY;
  //   }
  //   // for(int i = 0; i < result.length; i++){
  //   //   print('X: ${result[i].currentX.toString()}');
  //   //   print('y: ${result[i].currentY.toString()}');
  //   // }
  //   return result;
  // }

  // List<CurvePathInfo> generateCurveSegment(
  //   double startX,
  //   double startY,
  //   double width,
  //   double height,
  //   double weight,
  // ) {
  //   List<CurvePathInfo> result = [];
  //   double currentX = startX;
  //   double currentY = startY;
  //   double nextX;
  //   double nextY;
  //   double referPointX;
  //   double referPointY;
  //   int dirCount = 0;

  //  print('width: $width');
  // print('height: $height');

  // for (int i = 0; i < numberOfSegments; i++) {
  //   // determing the coordinate of the destination
  //   nextX = direction ? currentX + 8 * width / 20 : currentX - 8 * width / 20;
  //   nextY = currentY + 2 * height / 24 ;

  //   //determing the coordinate of the reference point
  //   if (direction) {
  //     referPointX = currentX < 6 * width / 20
  //         ? currentX + 1 * width / 20
  //         : nextX - 1 * width / 20;

  //     referPointY = currentX < 6 * width / 20 ? nextY : currentY;
  //   } else {
  //     referPointX = currentX < 14 * width / 20
  //         ? nextX + 1 * width / 20
  //         : currentX - 1 * width / 20;
  //     referPointY = currentX < 14 * width / 20 ? currentY : nextY;
  //   }

  // store the info in an object
  //     CurvePathInfo temp = CurvePathInfo(
  //       currentX: currentX,
  //       currentY: currentY,
  //       destX: nextX,
  //       destY: nextY,
  //       refX: referPointX,
  //       refY: referPointY,
  //       direction: direction,
  //       curveWeight: weight,
  //     );
  //     // print(temp.destX.toString());
  //     // print(temp.destY.toString());
  //     // print(temp.refX.toString());
  //     // print(temp.refY.toString());
  //     //change the coordinate of current point to prepare for the next round
  //     currentX = nextX;
  //     currentY = nextY;
  //     result.add(temp);
  //     dirCount++;
  //     if (dirCount == 2) {
  //       direction = !direction;
  //       dirCount = 0;
  //     }
  //   }

  //   return result;
  // }
  // }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 15.0;
    final _width = size.width;
    final _height = 3 * size.height / 4;
    // print('width in paint: $_width');
    // print('height in paint: $_height');
    final double _conicWeight = 1.2;

    var path = Path();
    var dashedPath = Path();

    //
    path.moveTo(1 * _width / 8, 0.0);
    dashedPath.moveTo(1 * _width / 8, 0.0);

    for (int i = 0; i < 13; i++) {
      //1st curve segment
      if (i == 0) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              1.2 * _width / 8,
              3.5 / 8 * _height / 8 + i ~/ 12 * _height,
              1.7 * _width / 8,
              5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              1.2 * _width / 8,
              3.5 / 8 * _height / 8 + i ~/ 12 * _height,
              1.7 * _width / 8,
              5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        path.moveTo(1.7 * _width / 8, 5 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            2 * _width / 8, 1 / 2 * _height / 8 + i ~/ 12 * _height);
        print('first curve');
      }
      //2nd curve segment
      if (i % 12 == 1) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              2.8 * _width / 8,
              8 / 8 * _height / 8 + i ~/ 12 * _height,
              2.8 * _width / 8,
              7 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              2.8 * _width / 8,
              8 / 8 * _height / 8 + i ~/ 12 * _height,
              2.8 * _width / 8,
              7 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        path.moveTo(
            2.6 * _width / 8, 7.2 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            2.6 * _width / 8, 7.2 / 8 * _height / 8 + i ~/ 12 * _height);
        print('second curve');
      }
      // 3rd curve segment
      if (i % 12 == 2) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              3.25 * _width / 8,
              7.8 / 8 * _height / 8 + i ~/ 12 * _height,
              4 * _width / 8,
              1 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              3.25 * _width / 8,
              7.8 / 8 * _height / 8 + i ~/ 12 * _height,
              4 * _width / 8,
              1 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
      }
      //4th curve segment
      if (i % 12 == 3) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              4.75 * _width / 8,
              1 * _height / 8 + i ~/ 12 * _height,
              5 * _width / 8,
              8.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              4.75 * _width / 8,
              1 * _height / 8 + i ~/ 12 * _height,
              5 * _width / 8,
              8.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('4th segment');
        path.moveTo(
            4.9 * _width / 8, 8.3 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            4.9 * _width / 8, 8.3 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      //5th curve segment
      if (i % 12 == 4) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              5.75 * _width / 8,
              1 * _height / 8 + i ~/ 12 * _height,
              6 * _width / 8,
              9.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              5.75 * _width / 8,
              8.8 / 8 * _height / 8 + i ~/ 12 * _height,
              6 * _width / 8,
              9.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('5th segment');
        path.moveTo(
            5.9 * _width / 8, 9.3 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            5 * _width / 8, 8.4 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      //6th curve segment
      if (i % 12 == 5) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              6.8 * _width / 8,
              11 / 8 * _height / 8 + i ~/ 12 * _height,
              7 * _width / 8,
              16 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              6.8 * _width / 8,
              11 / 8 * _height / 8 + i ~/ 12 * _height,
              7 * _width / 8,
              16 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(7 * _width / 8, 15.5 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            7 * _width / 8, 15.5 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      //7th curve segment
      if (i % 12 == 6) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              6.8 * _width / 8,
              11 / 8 * _height / 8 + i ~/ 12 * _height,
              7 * _width / 8,
              16 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              6.8 * _width / 8,
              21 / 8 * _height / 8 + i ~/ 12 * _height,
              6 * _width / 8,
              22 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(
            6.05 * _width / 8, 21.9 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            6.05 * _width / 8, 21.9 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      // 8th curve segment
      if (i % 12 == 7) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              6.8 * _width / 8,
              11 / 8 * _height / 8 + i ~/ 12 * _height,
              7 * _width / 8,
              16 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              5.8 * _width / 8,
              22.8 / 8 * _height / 8 + i ~/ 12 * _height,
              5 * _width / 8,
              23 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(
            5.05 * _width / 8, 22.83 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            5.05 * _width / 8, 22.83 / 8 * _height / 8 + i ~/ 12 * _height);
      }

      // 9th curve segment
      if (i % 12 == 8) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              4.8 * _width / 8,
              23.4 / 8 * _height / 8 + i ~/ 12 * _height,
              4 * _width / 8,
              23.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              4.8 * _width / 8,
              23.4 / 8 * _height / 8 + i ~/ 12 * _height,
              4 * _width / 8,
              23.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(4.1 * _width / 8, 23.5 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            4.1 * _width / 8, 23.5 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      // 10th curve segment
      if (i % 12 == 10) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              3.8 * _width / 8,
              24 / 8 * _height / 8 + i ~/ 12 * _height,
              3 * _width / 8,
              24.1 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              3.8 * _width / 8,
              24 / 8 * _height / 8 + i ~/ 12 * _height,
              3 * _width / 8,
              24.1 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(3 * _width / 8, 24.1 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            3 * _width / 8, 24.1 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      // 11th curve segment
      if (i % 12 == 11) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              4.8 * _width / 8,
              23.4 / 8 * _height / 8 + i ~/ 12 * _height,
              4 * _width / 8,
              23.5 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              2 * _width / 8,
              24 / 8 * _height / 8 + i ~/ 12 * _height,
              1.58 * _width / 8,
              27 / 8 * _height / 8 + i ~/ 12 * _height,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(1.6 * _width / 8, 26.9 / 8 * _height / 8 + i ~/ 12 * _height);
        dashedPath.moveTo(
            4 * _width / 8, 23.5 / 8 * _height / 8 + i ~/ 12 * _height);
      }
      // 12th curve segment
      if (i == 12) {
        if (dotList[i + 1].status == Status.FAIL) {
          dashedPath.conicTo(
              4.8 * _width / 8,
              23.4 / 8 * _height / 8 ,
              4 * _width / 8,
              23.5 / 8 * _height / 8 ,
              _conicWeight);
        }
        if (dotList[i + 1].status == Status.TICK) {
          path.conicTo(
              1.1 * _width / 8,
              30 / 8 * _height / 8 ,
              1 * _width / 8,
              32 / 8 * _height / 8 ,
              _conicWeight);
        }
        print('6th segment');
        path.moveTo(4 * _width / 8, 23.5 / 8 * _height / 8 );
        dashedPath.moveTo(
            4 * _width / 8, 23.5 / 8 * _height / 8 );
      }
    }
    canvas.drawPath(path, paint);
    canvas.drawPath(
      dashPath(
        dashedPath,
        dashArray: CircularIntervalList<double>([15.0, 10.5]),
      ),
      paint,
    );
  }
}
