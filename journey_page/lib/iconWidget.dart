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
    if (!widget.dot.isDummy) {
      // print('totalWidth: ${widget.totalWidth}');
      // print('totalHeight: ${widget.totalHeight}');
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
          : (widget.dot.dotType == Type.DAILY ? 30 : 55);
      _height = widget.dot.status == Status.CURRENT_LOCK
          ? 35
          : (widget.dot.dotType == Type.DAILY ? 30 : 55);
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
        default:
          _imageName = '';
          break;
      }
      switch (widget.index) {
        case 0:
          _coordinateX = widget.dot.sequenceNum == 0
              ? 0.8 * widget.totalWidth / 8
              : 0.75 * widget.totalWidth / 8;
          _coordinateY = widget.dot.sequenceNum == 0
              ? 0.0
              : -2 / 8 * widget.totalHeight / 8;

          break;

        case 1:
          _coordinateX = 1.35 * widget.totalWidth / 8;
          _coordinateY = 3.4 / 8 * widget.totalHeight / 8;
          break;
        case 2:
          _coordinateX = 2.35 * widget.totalWidth / 8;
          _coordinateY = 5.2 / 8 * widget.totalHeight / 8;
          break;
        case 3:
          _coordinateX = 3.6 * widget.totalWidth / 8;
          _coordinateY = 5.8 / 8 * widget.totalHeight / 8;
          break;
        case 4:
          _coordinateX = 4.7 * widget.totalWidth / 8;
          _coordinateY = 6.2 / 8 * widget.totalHeight / 8;
          break;
        case 5:
          _coordinateX = 5.85 * widget.totalWidth / 8;
          _coordinateY = 8.0 / 8 * widget.totalHeight / 8;
          break;
        case 6:
          _coordinateX = 6.55 * widget.totalWidth / 8;
          _coordinateY = 13.8 / 8 * widget.totalHeight / 8;
          break;
        case 7:
          _coordinateX = 5.85 * widget.totalWidth / 8;
          _coordinateY = 19.9 / 8 * widget.totalHeight / 8;
          break;
        case 8:
          _coordinateX = 4.7 * widget.totalWidth / 8;
          _coordinateY = 21.1 / 8 * widget.totalHeight / 8;
          break;
        case 9:
          _coordinateX = 3.6 * widget.totalWidth / 8;
          _coordinateY = 21.5 / 8 * widget.totalHeight / 8;
          break;
        case 10:
          _coordinateX = 2.42 * widget.totalWidth / 8;
          _coordinateY = 21.9 / 8 * widget.totalHeight / 8;
          break;
        case 11:
          _coordinateX = 1.3 * widget.totalWidth / 8;
          _coordinateY = 23.6 / 8 * widget.totalHeight / 8;
          break;
      }
    }
  }

  @override
  void dispose() {
    if(_controller != null)
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dot.isDummy) {
      return Container(
        color: Colors.transparent,
      );
    }

    // return animated icon if status is current_lock
    if (widget.dot.status == Status.CURRENT_LOCK) {
      return Positioned(
        left: _coordinateX,
        top: _coordinateY,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: SizedBox(
            width: widget.totalHeight * 0.07,
            height: widget.totalHeight * 0.07,
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
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    }
    // return regular icon if status is not current_lock
    else {
      return Positioned(
        left: _coordinateX,
        top: _coordinateY,
        //child: Text('H'),
        child: SizedBox(
          width: widget.totalHeight * 0.07,
          height: widget.totalHeight * 0.07,
          child: Opacity(
            opacity: widget.dot.sequenceNum > widget.changeOpacityPosition
                ? 0.8
                : 1.0,
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
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    }
  }
}
