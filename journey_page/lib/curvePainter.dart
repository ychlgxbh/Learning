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

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 15.0;
    final _width = size.width;
    final _height = 2 * size.height;
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
        if (dotList[i].status == Status.TICK) {
          path.conicTo(
            1.2 * _width / 8,
            3.5 / 8 * _height / 8,
            1.7 * _width / 8,
            5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            1.2 * _width / 8,
            3.5 / 8 * _height / 8,
            1.7 * _width / 8,
            5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          1.7 * _width / 8,
          5 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          1.7 * _width / 8,
          5 / 8 * _height / 8,
        );
        print('1st segment');
      }

      //2nd curve segment

      if (i == 1) {
        if (dotList[i].status == Status.TICK) {
          path.conicTo(
            2.8 * _width / 8,
            8 / 8 * _height / 8,
            2.8 * _width / 8,
            7 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            2.8 * _width / 8,
            8 / 8 * _height / 8,
            2.8 * _width / 8,
            7 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          2.6 * _width / 8,
          7.2 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          2.6 * _width / 8,
          7.2 / 8 * _height / 8,
        );
        print('2nd segment');
      }

      // 3rd curve segment
      if (i == 2) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            3.25 * _width / 8,
            7.8 / 8 * _height / 8,
            4 * _width / 8,
            1 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            3.25 * _width / 8,
            7.8 / 8 * _height / 8,
            4 * _width / 8,
            1 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          4 * _width / 8,
          8 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          4 * _width / 8,
          8 / 8 * _height / 8,
        );

        print('3rd segment');
      }
      //4th curve segment
      if (i == 3) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            4.75 * _width / 8,
            1 * _height / 8,
            5 * _width / 8,
            8.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            4.75 * _width / 8,
            1 * _height / 8,
            5 * _width / 8,
            8.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          4.9 * _width / 8,
          8.3 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          4.9 * _width / 8,
          8.3 / 8 * _height / 8,
        );
        print('4th segment');
      }

      //5th curve segment
      if (i == 4) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            5.75 * _width / 8,
            8.8 / 8 * _height / 8,
            6 * _width / 8,
            9.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            5.75 * _width / 8,
            8.8 / 8 * _height / 8,
            6 * _width / 8,
            9.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          5.9 * _width / 8,
          9.3 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          5.9 * _width / 8,
          9.3 / 8 * _height / 8,
        );
        print('5th segment');
      }
      //6th curve segment
      if (i == 5) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            6.8 * _width / 8,
            11 / 8 * _height / 8,
            7 * _width / 8,
            16 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            6.8 * _width / 8,
            11 / 8 * _height / 8,
            7 * _width / 8,
            16 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          7 * _width / 8,
          15.5 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          7 * _width / 8,
          15.5 / 8 * _height / 8,
        );
        print('6th segment');
      }
      //7th curve segment
      if (i == 6) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            6.8 * _width / 8,
            21 / 8 * _height / 8,
            6 * _width / 8,
            22 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            6.8 * _width / 8,
            21 / 8 * _height / 8,
            6 * _width / 8,
            22 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          6.05 * _width / 8,
          21.9 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          6.05 * _width / 8,
          21.9 / 8 * _height / 8,
        );
      }
      print('7th segment');

      // 8th curve segment
      if (i == 7) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            5.8 * _width / 8,
            22.8 / 8 * _height / 8,
            5 * _width / 8,
            23 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            5.8 * _width / 8,
            22.8 / 8 * _height / 8,
            5 * _width / 8,
            23 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          5.05 * _width / 8,
          22.83 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          5.05 * _width / 8,
          22.83 / 8 * _height / 8,
        );
      }
      print('8th segment');

      // 9th curve segment
      if (i == 8) {
        if (dotList[i].status == Status.TICK) {
          path.conicTo(
            4.8 * _width / 8,
            23.4 / 8 * _height / 8,
            4 * _width / 8,
            23.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            4.8 * _width / 8,
            23.4 / 8 * _height / 8,
            4 * _width / 8,
            23.5 / 8 * _height / 8,
            _conicWeight,
          );
        }

        path.moveTo(
          4.1 * _width / 8,
          23.5 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          4.1 * _width / 8,
          23.5 / 8 * _height / 8,
        );
        print('9th segment');
      }
      // 10th curve segment

      if (i == 9) {
        if (dotList[i].status == Status.TICK) {
          path.conicTo(
            3.8 * _width / 8,
            24 / 8 * _height / 8,
            3 * _width / 8,
            24.1 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            3.8 * _width / 8,
            24 / 8 * _height / 8,
            3 * _width / 8,
            24.1 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          3 * _width / 8,
          24.1 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          3 * _width / 8,
          24.1 / 8 * _height / 8,
        );
      }
      print('10th segment');
      // 11th curve segment
      if (i == 10) {
        if (dotList[i].status == Status.TICK) {
          path.conicTo(
            2 * _width / 8,
            24 / 8 * _height / 8,
            1.58 * _width / 8,
            27 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            2 * _width / 8,
            24 / 8 * _height / 8,
            1.58 * _width / 8,
            27 / 8 * _height / 8,
            _conicWeight,
          );
        }

        path.moveTo(
          1.6 * _width / 8,
          26.9 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          1.6 * _width / 8,
          26.9 / 8 * _height / 8,
        );
      }
      print('11th segment');
      // 12th curve segment
      if (i == 11) {
        if (dotList[i ].status == Status.TICK) {
          path.conicTo(
            1.1 * _width / 8,
            30 / 8 * _height / 8,
            1 * _width / 8,
            32 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i ].status == Status.FAIL) {
          dashedPath.conicTo(
            1.1 * _width / 8,
            30 / 8 * _height / 8,
            1 * _width / 8,
            32 / 8 * _height / 8,
            _conicWeight,
          );
        }
        path.moveTo(
          4 * _width / 8,
          23.5 / 8 * _height / 8,
        );
        dashedPath.moveTo(
          4 * _width / 8,
          23.5 / 8 * _height / 8,
        );
        print('12th segment');
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
