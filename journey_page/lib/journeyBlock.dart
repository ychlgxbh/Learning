import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_page/curvePainter.dart';
import 'package:journey_page/userInfo.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';

class JourneyBlock extends StatelessWidget {
  final double _bodyWidth;
  final double _bodyHeight;
 //final int _numberOfSegment;
 
  final List<Dot> dotList;
  

  JourneyBlock(this._bodyWidth, this._bodyHeight, this.dotList);

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i < dotList.length; i++){
      print(dotList[i]);
    }
    // final List<DrawingPoint> _drawingPoint = new CurvePainter()
    //     .getDrawingPoints(_bodyWidth, _bodyHeight, _numberOfSegment);
    // List<Widget> _textBetween = [];
    // final listOfChildren = _drawingPoint
    //     .map(
    //       (e) => Positioned(
    //         left: e.currentX,
    //         top: e.currentY,
    //         child: IconWidget(e.index),
    //       ),
    //     )
    //     .toList();
    // listOfChildren.insert(
    //   0,
    //   new Positioned(
    //     child: CustomPaint(
    //       painter: CurvePainter(),
    //       size: Size(MediaQuery.of(context).size.width,
    //           MediaQuery.of(context).size.height),
    //     ),
    //   ),
    // );
    // for (int i = 0; i < _drawingPoint.length; i++) {
    //   if (i == 0) {
    //     listOfChildren.insert(
    //       2,
    //       Positioned(
    //           left: _drawingPoint[i + 1].currentX,
    //           top: 0.4 * _drawingPoint[i + 2].currentY,
    //           child: new Text('START HERE!')),
    //     );
    //   }
    //   if (i == 3) {
    //     listOfChildren.insert(
    //       2,
    //       Positioned(
    //           left: _drawingPoint[i - 1].currentX,
    //           top: 1.1 * _drawingPoint[i + 3].currentY,
    //           child: new Text('1 WEEK DOWN. GOOD JOB!')),
    //     );
    //   }
    //   if (i == 15) {
    //     listOfChildren.insert(
    //       2,
    //       Positioned(
    //           left: _drawingPoint[i - 1].currentX,
    //           top: 1.03 * _drawingPoint[i + 3].currentY,
    //           child: new Text('SILVER STARTS HERE!')),
    //     );
    //   }
    //   // if (i == 27) {
    //   //   listOfChildren.insert(2,
    //   //     Positioned(
    //   //         left: _drawingPoint[i+1].currentX,
    //   //         top: 1.03 * _drawingPoint[i + 3].currentY,
    //   //         child: new Text('PERFECT!')),
    //   //   );
    //   // }
    //   if (i == 39) {
    //     listOfChildren.insert(
    //       2,
    //       Positioned(
    //           left: _drawingPoint[i - 1].currentX,
    //           top: 1 * _drawingPoint[i + 3].currentY,
    //           child: new Text('YOU\'RE DOING GOOD!')),
    //     );
    //   }
    // }

    // return Stack(
    //   fit: StackFit.loose,
    //   children: listOfChildren,
    // );
    return Container();
  }
}
