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
  final int index;

  final List<Dot> dotList;

  JourneyBlock(this._bodyWidth, this._bodyHeight, this.dotList, this.index);

  @override
  Widget build(BuildContext context) {
    print('build journey block');
    final paint = Positioned(
      left: 0.0,
      top: 0.0,
      child: CustomPaint(
        painter: CurvePainter(
          dotList,
          index,
        ),
        size: Size(
          _bodyWidth,
          _bodyHeight / 2.8,
        ),
      ),
    );
    List<Widget> stackChildren = [];
    stackChildren.add(paint);
    stackChildren.addAll(
      dotList
          .map(
            (e) => IconWidget(
              e,
              dotList.indexOf(e),
              _bodyWidth,
              2 * _bodyHeight / 2.8,
            ),
          )
          .toList(),
    );
    print('stackChildren length: ${stackChildren.length}');

    return Container(
      margin: EdgeInsets.zero,
      height: _bodyHeight / 2.8,
      width: _bodyWidth,
      child: Container(
        width: _bodyWidth,
        height: _bodyHeight/2.8,
        child: Stack(
          fit: StackFit.expand,
          children: stackChildren,
        ),
      ),
    );
  }
}
