import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final int _index;
  IconWidget(this._index);
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
        constraints: BoxConstraints(minWidth: 10, minHeight: 10),
        onPressed: null,
        fillColor: Colors.red,
        shape: CircleBorder(),
        child: Image.asset('asset/Icon/medal.png',
          width: (widget._index) % 3 == 0 ? 35 : 15,
          height: (widget._index) % 3 == 0 ? 35 : 15,
          
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
