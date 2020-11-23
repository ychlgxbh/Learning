import 'package:flutter/material.dart';
import 'package:journey_page/iconWidget.dart';

import 'curvePathInfo.dart';

class ListOfWidgets extends StatelessWidget {
  final List<CurvePathInfo> curvePathInfo;
  ListOfWidgets(this.curvePathInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: curvePathInfo
            .map(
              (e) => Transform(
                transform: Matrix4.translationValues(e.currentX, e.currentY, 0),
                child: IconWidget(),
              ),
            )
            .toList(),
      ),
    );
  }
}
