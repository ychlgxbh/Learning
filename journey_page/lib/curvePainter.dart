import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:journey_page/curvePathInfo.dart';
import 'package:journey_page/userInfo.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:path_drawing/path_drawing.dart';

class CurvePainter extends CustomPainter {
  static int callingCount = 0;
  final List<Dot> dotList;
  int index;
  int _changeOpacityPosition;
  CurvePainter(
    this.dotList,
    this.index,
    this._changeOpacityPosition,
  );
  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    // paint.imageFilter = ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0,);
    final _width = size.width;
    final _height = 2 * size.height;
    //print('width in canvas: $_width');
    //print('height in canvas: $_height');
    // //print('width in paint: $_width');
    // //print('height in paint: $_height');
    final double _conicWeight = 1.2;
    double _pathStartX = 1.09 * _width / 8;
    double _pathStartY = 0.0;
    //print('in paint method');

    for (int i = 0; i < dotList.length; i++) {
      var paint = Paint();
      var path = Path();
      var dashedPath = Path();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 15.0;
      paint.color = dotList[i].sequenceNum > _changeOpacityPosition
          ? Color.fromRGBO(255, 255, 255, 0.6)
          : Colors.white;
      path.moveTo(
        _pathStartX,
        _pathStartY,
      );
      dashedPath.moveTo(
        _pathStartX,
        _pathStartY,
      );

      //1st curve segment
      if (i == 0) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            1.05 * _width / 8,
            3.8 / 8 * _height / 8,
            1.7 * _width / 8,
            5.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            1.05 * _width / 8,
            3.8 / 8 * _height / 8,
            1.7 * _width / 8,
            5.5 / 8 * _height / 8,
            _conicWeight,
          );
        }
        _pathStartX = 1.7 * _width / 8;
        _pathStartY = 5.5 / 8 * _height / 8;
        //print('1st segment');
      }

      //2nd curve segment

      else if (i == 1) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            2.3 * _width / 8,
            7.4 / 8 * _height / 8,
            2.6 * _width / 8,
            7.2 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            2.2 * _width / 8,
            8 / 8 * _height / 8,
            2.7 * _width / 8,
            7.2 / 8 * _height / 8,
            _conicWeight,
          );
        }
        _pathStartX = 2.7 * _width / 8;
        _pathStartY = 7.3 / 8 * _height / 8;
        //print('2nd segment');
      }

      // 3rd curve segment
      else if (i == 2) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            3.25 * _width / 8,
            7.8 / 8 * _height / 8,
            4 * _width / 8,
            1 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            3.25 * _width / 8,
            7.8 / 8 * _height / 8,
            4 * _width / 8,
            1 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 4 * _width / 8;
        _pathStartY = 8 / 8 * _height / 8;
        //print('3rd segment');
      }
      //4th curve segment
      else if (i == 3) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            4.75 * _width / 8,
            1 * _height / 8,
            5 * _width / 8,
            8.4 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            4.75 * _width / 8,
            1 * _height / 8,
            5 * _width / 8,
            8.4 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 5.05 * _width / 8;
        _pathStartY = 8.4 / 8 * _height / 8;

        //print('4th segment');
      }

      //5th curve segment
      else if (i == 4) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            5.75 * _width / 8,
            8.8 / 8 * _height / 8,
            6.15 * _width / 8,
            9.8 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            5.75 * _width / 8,
            8.8 / 8 * _height / 8,
            6.1 * _width / 8,
            9.8 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 6.1 * _width / 8;
        _pathStartY = 9.8 / 8 * _height / 8;

        //print('5th segment');
      }
      //6th curve segment
      else if (i == 5) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            6.8 * _width / 8,
            11 / 8 * _height / 8,
            6.9 * _width / 8,
            16 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            6.8 * _width / 8,
            11 / 8 * _height / 8,
            6.9 * _width / 8,
            16 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 6.9 * _width / 8;
        _pathStartY = 16.5 / 8 * _height / 8;

        //print('6th segment');
      }
      //7th curve segment
      else if (i == 6) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            6.8 * _width / 8,
            21 / 8 * _height / 8,
            6.15 * _width / 8,
            21.9 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            6.8 * _width / 8,
            21 / 8 * _height / 8,
            6.15 * _width / 8,
            21.9 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 6.15 * _width / 8;
        _pathStartY = 21.9 / 8 * _height / 8;

        //print('7th segment');
      }

      // 8th curve segment
      else if (i == 7) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            5.8 * _width / 8,
            22.8 / 8 * _height / 8,
            5.1 * _width / 8,
            23 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            5.8 * _width / 8,
            22.8 / 8 * _height / 8,
            5.1 * _width / 8,
            23 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 5 * _width / 8;
        _pathStartY = 23 / 8 * _height / 8;

        //print('8th segment');
      }

      // 9th curve segment
      else if (i == 8) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            4.8 * _width / 8,
            23.2 / 8 * _height / 8,
            3.9 * _width / 8,
            23.38 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            4.8 * _width / 8,
            23.2 / 8 * _height / 8,
            3.9 * _width / 8,
            23.38 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 3.9 * _width / 8;
        _pathStartY = 23.38 / 8 * _height / 8;

        //print('9th segment');
      }
      // 10th curve segment

      else if (i == 9) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            3.8 * _width / 8,
            23.6 / 8 * _height / 8,
            3 * _width / 8,
            23.8 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            3.8 * _width / 8,
            23.6 / 8 * _height / 8,
            3 * _width / 8,
            23.8 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 3.0 * _width / 8;
        _pathStartY = 23.8 / 8 * _height / 8;

        //print('10th segment');
      }

      // 11th curve segment
      else if (i == 10) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            2 * _width / 8,
            24 / 8 * _height / 8,
            1.58 * _width / 8,
            26 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            2 * _width / 8,
            24 / 8 * _height / 8,
            1.58 * _width / 8,
            26 / 8 * _height / 8,
            _conicWeight,
          );
        }

        _pathStartX = 1.7 * _width / 8;
        _pathStartY = 25.38 / 8 * _height / 8;

        //print('11th segment');
      }

      // 12th curve segment
      else if (i == 11) {
        if (dotList[i].status != Status.FAIL) {
          path.conicTo(
            1 * _width / 8,
            29 / 8 * _height / 8,
            1.08 * _width / 8,
            32 / 8 * _height / 8,
            _conicWeight,
          );
        }
        if (dotList[i].status == Status.FAIL) {
          dashedPath.conicTo(
            1 * _width / 8,
            29 / 8 * _height / 8,
            1.08 * _width / 8,
            32 / 8 * _height / 8,
            _conicWeight,
          );
        }
        //print('12th segment');
      }
      canvas.drawPath(
        path,
        paint,
      );
      canvas.drawPath(
        dashPath(
          dashedPath,
          dashArray:
              CircularIntervalList<double>([0.01 * _height, 0.01 * _height]),
        ),
        paint,
      );
    }

    //print('end of journey block');
    callingCount++;
    //print('created by $index');
  }
}
