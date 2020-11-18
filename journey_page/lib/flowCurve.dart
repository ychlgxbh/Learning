import 'package:flutter/material.dart';
import 'package:journey_page/flowCurveDelegate.dart';
import 'package:journey_page/flowWidgetItem.dart';
import 'package:journey_page/iconPosition.dart';

class FlowCurve extends StatefulWidget {
  final double diametre;
  final List<IconPosition> iconPosition;
  FlowCurve(this.diametre, this.iconPosition);
  @override
  _FlowCurveState createState() => _FlowCurveState();
}

class _FlowCurveState extends State<FlowCurve>
    with SingleTickerProviderStateMixin {
  AnimationController curveAnimation;
  final List<IconData> curveItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
    Icons.menu,
    Icons.menu,
    Icons.menu,
    Icons.menu,
    Icons.menu,
    Icons.menu,
  ];

  @override
  void initState() {
    super.initState();
    curveAnimation = AnimationController(
      duration: const Duration(microseconds: 250),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flow(
        delegate: FlowCurveDelegate(widget.iconPosition,curveAnimation: curveAnimation,),
        children: curveItems
            .map<Widget>(
              (IconData icon) => FlowWidgetItem(widget.diametre, icon))
            .toList(),
      ),
    );
  }
}
