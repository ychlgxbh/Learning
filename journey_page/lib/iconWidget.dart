import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      lowerBound: 0.35,
      upperBound: 0.5,
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: RawMaterialButton(
        constraints: BoxConstraints(minWidth: 20, maxHeight: 20),
        onPressed: null,
        fillColor: Colors.white,
        shape: CircleBorder(),
        child: FlutterLogo(size: 10.0),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
