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
      lowerBound: 0.3,
      upperBound: 0.4,
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _imageName = (widget._index + 1) % 4 == 0
        ? ((widget._index + 1) % 16 == 0
            ? 'lib/asset/Icon/upgrade.png'
            : 'lib/asset/Icon/upgrade.png')
        : 'lib/asset/Icon/current_point.png';
    if (widget._index == 0) {
      _imageName = 'lib/asset/Icon/current_point.png';
    }
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: RawMaterialButton(
        constraints: BoxConstraints(minWidth: 10, minHeight: 10),
        onPressed: null,
        fillColor: Colors.white,
        shape: CircleBorder(),
        child: Image.asset(
          _imageName,
          width: (widget._index + 1) % 4 == 0 && widget._index != 0 ? 40 : 20,
          height: (widget._index + 1) % 4 == 0 && widget._index != 0 ? 40 : 20,
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
