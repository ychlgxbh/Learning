import 'package:flutter/material.dart';
import 'package:journey_page/userInfo.dart';

class IconWidget extends StatefulWidget {
  final Dot dot;
  final int index;
  final double totalWidth;
  final double totalHeight;
  IconWidget(
    this.dot,
    this.index,
    this.totalWidth,
    this.totalHeight,
  );

  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _width;
  double _height;
  double _coordinateX;
  double _coordinateY;

  String _imageName;
  static bool _hasReachedCurrentLock = false;
  @override
  void initState() {
    super.initState();
    print('totalWidth: ${widget.totalWidth}');
    print('totalHeight: ${widget.totalHeight}');
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      lowerBound: 0.5,
      upperBound: 1.0,
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _width = widget.dot.status == Status.CURRENT_LOCK
        ? 30
        : (widget.dot.dotType == Type.DAILY ? 20 : 40);
    _height = widget.dot.status == Status.CURRENT_LOCK
        ? 30
        : (widget.dot.dotType == Type.DAILY ? 20 : 40);
    if (widget.dot.status == Status.CURRENT_LOCK) {
      _hasReachedCurrentLock = true;
    }
    switch (widget.dot.dotType) {
      case Type.DAILY:
        _imageName = widget.dot.status == Status.CURRENT_LOCK
            ? 'lib/asset/Icon/current_point.png'
            : (widget.dot.status == Status.LOCK
                ? 'lib/asset/Icon/lock.png'
                : 'lib/asset/Icon/tick.png');
        break;
      case Type.WEEKLY:
        _imageName = widget.dot.status == Status.LOCK
            ? (_hasReachedCurrentLock
                ? 'lib/asset/Icon/medalTBA@2x.png'
                : 'lib/asset/Icon/medal@2x.png')
            : 'lib/asset/Icon/medal_active@2x.png';
        break;
      case Type.TIER:
        _imageName = widget.dot.status == Status.LOCK
            ? 'lib/asset/Icon/upgrade@2x.png'
            : 'lib/asset/Icon/upgrade_focus@2x.png';
        break;
    }
    switch (widget.index) {
      case 0:
        _coordinateX = 0.8 * widget.totalWidth / 8;
        _coordinateY = 0.0;
        break;

      case 1:
        _coordinateX = 1.7 * widget.totalWidth / 8;
        _coordinateY = 5 / 8 * widget.totalHeight / 8;
        break;
      case 2:
        _coordinateX = 2.6 * widget.totalWidth / 8;
        _coordinateY = 7.2 / 8 * widget.totalHeight / 8;
        break;
      case 3:
        _coordinateX = 4 * widget.totalWidth / 8;
        _coordinateY = 8 / 8 * widget.totalHeight / 8;
        break;
      case 4:
        _coordinateX = 4.9 * widget.totalWidth / 8;
        _coordinateY = 8.3 / 8 * widget.totalHeight / 8;
        break;
      case 5:
        _coordinateX = 5.9 * widget.totalWidth / 8;
        _coordinateY = 9.3 / 8 * widget.totalHeight / 8;
        break;
      case 6:
        _coordinateX = 7 * widget.totalWidth / 8;
        _coordinateY = 15.5 / 8 * widget.totalHeight / 8;
        break;
      case 7:
        _coordinateX = 6.05 * widget.totalWidth / 8;
        _coordinateY = 21.9 / 8 * widget.totalHeight / 8;
        break;
      case 8:
        _coordinateX = 5.05 * widget.totalWidth / 8;
        _coordinateY = 22.83 / 8 * widget.totalHeight / 8;
        break;
      case 9:
        _coordinateX = 4.1 * widget.totalWidth / 8;
        _coordinateY = 23.5 / 8 * widget.totalHeight / 8;
        break;
      case 10:
        _coordinateX = 3 * widget.totalWidth / 8;
        _coordinateY = 24.1 / 8 * widget.totalHeight / 8;
        break;
      case 11:
        _coordinateX = 2 * widget.totalWidth / 8;
        _coordinateY = 26.9 / 8 * widget.totalHeight / 8;
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // set img names

    if (widget.dot.status == Status.CURRENT_LOCK) {
      return Positioned(
        left: _coordinateX,
        top: _coordinateY,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: RawMaterialButton(
            
            constraints: BoxConstraints(minWidth: 10, minHeight: 10),
            onPressed: null,
            fillColor: Colors.white,
            shape: CircleBorder(),
            child: Image.asset(
              _imageName,
              width: _width,
              height: _height,
            ),
            padding: EdgeInsets.all(0.0),
          ),
        ),
      );
    } else {
      return Positioned(
        left: _coordinateX,
        top: _coordinateY,
        child: RawMaterialButton(
          constraints: BoxConstraints(minWidth: 10, minHeight: 10),
          onPressed: null,
          fillColor: Colors.white,
          shape: CircleBorder(),
          child: Image.asset(
            _imageName,
            fit: BoxFit.fill,
            width: _width,
            height: _height,
          ),
          padding: EdgeInsets.all(0.0),
        ),
      );
    }
  }
}
