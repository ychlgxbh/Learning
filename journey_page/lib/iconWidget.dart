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
      lowerBound: 0.5,
      upperBound: 1.0,
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
            : 'lib/asset/Icon/medal.png')
        : 'lib/asset/Icon/lock.png';
    String _textString = '';
    switch (widget._index) {
      case 6:
        _textString = '1 WEEK DOWN. GOOD JOB!';
        break;
      case 12:
        _textString = 'KEEP IT UP!';
        break;
      case 18:
        _textString = 'SILVER STARTS HERE';
        break;
      case 24:
        _textString = 'ANOTHOR WEEK DOWN!';
        break;
      case 30:
        _textString = 'PERFECT!';
        break;
      case 36:
        _textString = 'GOLD STATRS HERE';
        break;
      case 42:
        _textString = 'YOU\'RE DOING GOOD!';
        break;
      case 48:
        _textString = 'ALMOST THRER!';
        break;
      case 54:
        _textString = 'YOUR BONUS IS WAITING!';
        break;
    }
    if (widget._index == 0) {
      _imageName = 'lib/asset/Icon/current_point.png';
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
            width: (widget._index + 1) % 4 == 0 && widget._index != 0 ? 40 : 30,
            height:
                (widget._index + 1) % 4 == 0 && widget._index != 0 ? 40 : 30,
          ),
          padding: EdgeInsets.all(5.0),
        ),
      );
    } else {
      if (widget._index % 12 == 0) {
        return Row(
          children: [
            RawMaterialButton(
              constraints: BoxConstraints(minWidth: 10, minHeight: 10),
              onPressed: null,
              fillColor: Colors.white,
              shape: CircleBorder(),
              child: Image.asset(
                _imageName,
                width: (widget._index + 1) % 4 == 0 && widget._index != 0
                    ? 20
                    : 10,
                height: (widget._index + 1) % 4 == 0 && widget._index != 0
                    ? 20
                    : 10,
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Text(_textString),
          ],
        );
      }
      // if (widget._index % 12 == 6 ) {
      //   return Row(
      //     textDirection: TextDirection.rtl,
      //     textBaseline: TextBaseline.alphabetic,
      //     children: [
      //       Text(_textString),
      //       RawMaterialButton(
      //         constraints: BoxConstraints(minWidth: 10, minHeight: 10),
      //         onPressed: null,
      //         fillColor: Colors.white,
      //         shape: CircleBorder(),
      //         child: Image.asset(
      //           _imageName,
      //           width: (widget._index + 1) % 4 == 0 && widget._index != 0
      //               ? 20
      //               : 10,
      //           height: (widget._index + 1) % 4 == 0 && widget._index != 0
      //               ? 20
      //               : 10,
      //         ),
      //         padding: EdgeInsets.all(10.0),
      //       ),

      //     ],
      //   );
    }
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth: 10, minHeight: 10),
      onPressed: null,
      fillColor: Colors.white,
      shape: CircleBorder(),
      child: Image.asset(
        _imageName,
        width: (widget._index + 1) % 4 == 0 && widget._index != 0 ? 20 : 10,
        height: (widget._index + 1) % 4 == 0 && widget._index != 0 ? 20 : 10,
      ),
      padding: EdgeInsets.all(10.0),
    );
  }
}
