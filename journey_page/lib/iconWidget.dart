import 'package:flutter/material.dart';
import 'package:journey_page/userInfo.dart';
import 'package:intl/intl.dart';

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
  String _title = '';
  @override
  void initState() {
    super.initState();
    if (!widget.dot.isDummy) {
      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        lowerBound: 0.8,
        upperBound: 1.0,
        vsync: this,
      )..repeat(reverse: true);
      _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      );
      _width = widget.dot.status == Status.CURRENT_LOCK
          ? 35
          : (widget.dot.dotType == Type.DAILY ? 25 : 55);
      _height = widget.dot.status == Status.CURRENT_LOCK
          ? 35
          : (widget.dot.dotType == Type.DAILY ? 25 : 55);
      if (widget.dot.status == Status.CURRENT_LOCK) {
        _hasReachedCurrentLock = true;
      }
      switch (widget.dot.dotType) {
        case Type.DAILY:
          _imageName = widget.dot.status == Status.CURRENT_LOCK
              ? 'lib/asset/Icon/current_point.png'
              : (widget.dot.status == Status.LOCK
                  ? 'lib/asset/Icon/lock.png'
                  : (widget.dot.status == Status.FAIL)
                      ? 'lib/asset/Icon/cross.png'
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
              ? 0.7 * widget.totalWidth / 8
              : 0.65 * widget.totalWidth / 8;
          _coordinateY = widget.dot.sequenceNum == 0
              ? 0.0
              : -2 / 8 * widget.totalHeight / 8;
          break;
        case 1:
          _coordinateX = 1.35 * widget.totalWidth / 8;
          _coordinateY = 3.4 / 8 * widget.totalHeight / 8;
          break;
        case 2:
          _coordinateX = 2.3 * widget.totalWidth / 8;
          _coordinateY = 5.1 / 8 * widget.totalHeight / 8;
          break;
        case 3:
          _coordinateX = 3.6 * widget.totalWidth / 8;
          _coordinateY = 5.6 / 8 * widget.totalHeight / 8;
          break;
        case 4:
          _coordinateX = 4.7 * widget.totalWidth / 8;
          _coordinateY = 6.0 / 8 * widget.totalHeight / 8;
          break;
        case 5:
          _coordinateX = 5.75 * widget.totalWidth / 8;
          _coordinateY = 7.8 / 8 * widget.totalHeight / 8;
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
          _coordinateX = 4.7 * widget.totalWidth / 8;
          _coordinateY = 20.2 / 8 * widget.totalHeight / 8;
          break;
        case 9:
          _coordinateX = 3.6 * widget.totalWidth / 8;
          _coordinateY = 21.1 / 8 * widget.totalHeight / 8;
          break;
        case 10:
          _coordinateX = 2.42 * widget.totalWidth / 8;
          _coordinateY = 21.6 / 8 * widget.totalHeight / 8;
          break;
        case 11:
          _coordinateX = 1.3 * widget.totalWidth / 8;
          _coordinateY = 23.5 / 8 * widget.totalHeight / 8;
          break;
      }
    }
  }
// Set alert dialog

  Future<void> _showDialog() async {
    switch (widget.dot.dotType) {
      case Type.DAILY:
        _title = widget.dot.status == Status.CURRENT_LOCK
            ? 'TODAY\'S GOAL'
            : (widget.dot.status == Status.TICK
                ? new DateFormat.yMMMd().format(widget.dot.day)
                : 'NEXT GOAL');
        break;
      case Type.WEEKLY:
        _title = 'WEEKLY GOAL';
        break;
      case Type.TIER:
        _title = 'LEVEL UP GOAL';
        break;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          actionsPadding: EdgeInsets.only(
            bottom: 0.02 * widget.totalHeight,
          ),
          titlePadding: EdgeInsets.symmetric(
            vertical: 0.01 * widget.totalHeight,
            horizontal: 0.0,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.01 * widget.totalHeight,
            horizontal: 0.1 * widget.totalWidth,
          ),
          title: Center(
            child: Text(_title),
          ),
          content: SizedBox(
            height: 0.4 * widget.totalHeight,
            width: 0.7 * widget.totalWidth,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 0.195 * widget.totalHeight,
                      width: 0.65 * widget.totalWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Color(0xFFEAF6FF),
                      ),
                      child: Center(
                        child: Text(
                          'PLACEHOLDER',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.01 * widget.totalHeight,
                    ),
                    Container(
                      height: 0.195 * widget.totalHeight,
                      width: 0.65 * widget.totalWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Color(0xFFEAF6FF),
                      ),
                      child: Center(
                        child: Text(
                          'PLACEHOLDER',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: CircleAvatar(
                    radius: 0.035 * widget.totalWidth,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        '=',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: widget.dot.status == Status.CURRENT_LOCK
              ? <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 0.05 * widget.totalWidth,
                        ),
                        child: Text(
                          '     SELECT WORKOUT     ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.01 * widget.totalHeight,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.grey,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 0.05 * widget.totalWidth,
                        ),
                        child: Text(
                          '       I\'LL DO IT LATER       ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              : <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 0.05 * widget.totalWidth,
                        ),
                        child: Text(
                          '     OK, UNDERSTOOD     ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
        );
      },
    );
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
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
            width: widget.totalHeight * 0.08,
            height: widget.totalHeight * 0.08,
            child: RawMaterialButton(
              elevation: 0.0,
              disabledElevation: 0.0,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              onPressed: _showDialog,
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
        child: SizedBox(
          width: widget.totalHeight * 0.08,
          height: widget.totalHeight * 0.08,
          child: Opacity(
            opacity: widget.dot.sequenceNum > widget.changeOpacityPosition
                ? 0.9
                : 1.0,
            child: RawMaterialButton(
              elevation: 0.0,
              disabledElevation: 0.0,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              onPressed: _showDialog,
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
