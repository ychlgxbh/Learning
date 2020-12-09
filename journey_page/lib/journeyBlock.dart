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
  final int _changeOpacityPosition;
  final List<String> _bodyTextList;
  final List<Dot> dotList;

  JourneyBlock(
    this._bodyWidth,
    this._bodyHeight,
    this.dotList,
    this.index,
    this._changeOpacityPosition,
    this._bodyTextList,
  );

  @override
  Widget build(BuildContext context) {
   
    //get curve segments
    final paint = Positioned(
      left: 0.0,
      top: 0.0,
      child: CustomPaint(
        painter: CurvePainter(
          dotList,
          index,
          _changeOpacityPosition,
        ),
        size: Size(
          _bodyWidth,
          _bodyHeight / 2.81,
        ),
      ),
    );
    //
    List<Widget> stackChildren = [];
    stackChildren.add(paint);
    //get icons
    stackChildren.addAll(
      dotList
          .map(
            (e) => IconWidget(
              e,
              dotList.indexOf(e),
              _bodyWidth,
              2 * _bodyHeight / 2.8,
              _changeOpacityPosition,
            ),
          )
          .toList(),
    );

    stackChildren.addAll(
      _bodyTextList.map(
        (e) => Positioned(
          left: _bodyTextList.indexOf(e) == 0 ? 1.8 * _bodyWidth / 8 : 2.8 * _bodyWidth / 8,
          top: _bodyTextList.indexOf(e) == 0
              ? (index == 0 ? 1 / 8 * _bodyHeight / 8 / 2.8 : 0.0)
              : 30 / 8 * _bodyHeight / 8 / 2.8,
          child: Text(e,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),
    );

    // print('stackChildren length: ${stackChildren.length}');
    // print('changeOpacityPosition: $_changeOpacityPosition');
    return Container(
      margin: EdgeInsets.zero,
      height: _bodyHeight / 2.8,
      width: _bodyWidth,
      child: Container(
        width: _bodyWidth,
        height: _bodyHeight / 2.8,
        child: Stack(
          overflow: Overflow.visible,
          fit: StackFit.expand,
          children: stackChildren,
        ),
      ),
    );
  }
}
