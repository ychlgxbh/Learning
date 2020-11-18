import 'package:flutter/material.dart';
import 'package:journey_page/iconPosition.dart';

class FlowWidgetItem extends StatelessWidget {
  final double diametre;
  final IconData icon;

  FlowWidgetItem(this.diametre, this.icon);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: Colors.amber,
      child: Icon(
        icon,
        size: 30,
      ),
      constraints: BoxConstraints.tight(
        Size(diametre, diametre),
      ),
      onPressed: () {},
    );
  }
}
