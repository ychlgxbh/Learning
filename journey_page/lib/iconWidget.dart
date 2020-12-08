import 'package:flutter/material.dart';
import 'package:journey_page/userInfo.dart';

class IconWidget extends StatefulWidget {
  final Dot dot;
  final int index;
  final double totalWidth;
  final double totalHeight;
  final int changeOpacityPosition;
  IconWidget(
    this.dot,
    this.index,
    this.totalWidth,
    this.totalHeight,
    this.changeOpacityPosition,
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
  // static bool _changeOpacity = false;
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
        ? 35
        : (widget.dot.dotType == Type.DAILY ? 25 : 45);
    _height = widget.dot.status == Status.CURRENT_LOCK
        ? 35
        : (widget.dot.dotType == Type.DAILY ? 25 : 45);
    if (widget.dot.status == Status.CURRENT_LOCK) {
      _hasReachedCurrentLock = true;
    }
    // if(_hasReachedCurrentLock && widget.dot.dotType != Type.DAILY){
    //   _changeOpacity = true;
    // }
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
                : 'lib/asset/Icon/medal_white@2x.png')
            : 'lib/asset/Icon/medal_active@2x.png';
        if (_hasReachedCurrentLock) {
          _hasReachedCurrentLock = false;
        }
        break;
      case Type.TIER:
        _imageName = widget.dot.status == Status.LOCK
            ? 'lib/asset/Icon/upgrade@2x.png'
            : 'lib/asset/Icon/upgrade_focus@2x.png';
        break;
    }
    switch (widget.index) {
      case 0:
        _coordinateX = 0.65 * widget.totalWidth / 8;
        _coordinateY = 0.0;
        break;

      case 1:
        _coordinateX = 1.6 * widget.totalWidth / 8;
        _coordinateY = 4 / 8 * widget.totalHeight / 8;
        break;
      case 2:
        _coordinateX = 2.7 * widget.totalWidth / 8;
        _coordinateY = 5.5 / 8 * widget.totalHeight / 8;
        break;
      case 3:
        _coordinateX = 3.7 * widget.totalWidth / 8;
        _coordinateY = 5.6 / 8 * widget.totalHeight / 8;
        break;
      case 4:
        _coordinateX = 4.8 * widget.totalWidth / 8;
        _coordinateY = 6.2 / 8 * widget.totalHeight / 8;
        break;
      case 5:
        _coordinateX = 5.85 * widget.totalWidth / 8;
        _coordinateY = 8.5 / 8 * widget.totalHeight / 8;
        break;
      case 6:
        _coordinateX = 6.45 * widget.totalWidth / 8;
        _coordinateY = 13.8 / 8 * widget.totalHeight / 8;
        break;
      case 7:
        _coordinateX = 5.85 * widget.totalWidth / 8;
        _coordinateY = 19 / 8 * widget.totalHeight / 8;
        break;
      case 8:
        _coordinateX = 4.8 * widget.totalWidth / 8;
        _coordinateY = 20.5 / 8 * widget.totalHeight / 8;
        break;
      case 9:
        _coordinateX = 3.7 * widget.totalWidth / 8;
        _coordinateY = 21 / 8 * widget.totalHeight / 8;
        break;
      case 10:
        _coordinateX = 2.7 * widget.totalWidth / 8;
        _coordinateY = 21.5 / 8 * widget.totalHeight / 8;
        break;
      case 11:
        _coordinateX = 1.4 * widget.totalWidth / 8;
        _coordinateY = 23 / 8 * widget.totalHeight / 8;
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
          child: SizedBox(
            width: 45,
            height: 45,
            child: RawMaterialButton(
              // materialTapTargetSize: MaterialTapTargetSize.padded,
              constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              onPressed: null,
              fillColor: Colors.transparent,
              shape: CircleBorder(),
              child: Image.asset(
                _imageName,
                width: _width,
                height: _height,
              ),
              padding: EdgeInsets.all(0.0),
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        left: _coordinateX,
        top: _coordinateY,
        //child: Text('H'),
        child: SizedBox(
          width: 45,
          height: 45,
          child: Opacity(
            opacity: widget.dot.sequenceNum > widget.changeOpacityPosition ? 0.6 : 1.0,
            child: RawMaterialButton(
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              onPressed: null,
              fillColor: Colors.transparent,
              shape: CircleBorder(),
              child: Image.asset(
                _imageName,
                width: _width,
                height: _height,
              ),
              padding: EdgeInsets.all(0.0),
            ),
          ),
        ),
      );
    }
  }
}
