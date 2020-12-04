import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:journey_page/CurvePainter.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';
import 'package:journey_page/journeyBlock.dart';
import 'package:journey_page/blockListView.dart';
import 'package:journey_page/userInfo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Journey page demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _sharedValue = 0;

  final Map<int, Widget> _label = <int, Widget>{
    0: Text('       Journey Map       '),
    1: Text('       Activity       '),
  };
  List<Dot> totalDots = [];
  @override
  void initState() {
    super.initState();
    loadAsset().then((value) {
      setState(() {
        totalDots = userInfoFromJson(value).dots;
      });
    });
  }

  Future<String> loadAsset() async {
    print('in loadasset');
    return await rootBundle.loadString('lib/asset/jsons/journeyMap.json');
  }

  // Future<String> loadAsset() async {
  //   return rootBundle.loadString('lib/asset/jsons/journeyMap.json',
  //       cache: false);
  // }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _bodyHeight = _mediaQuery.size.height;
    final _bodyWidth = (_mediaQuery.size.width - 22);

    // final List<DrawingPoint> _drawingPoint =
    //     new CurvePainter().getDrawingPoints(_bodyWidth, _bodyHeight, 11);

    // final listOfChildren = _drawingPoint
    //     .map(
    //       (e) => Positioned(
    //         left: e.currentX,
    //         top: e.currentY,
    //         child: IconWidget(e.index),
    //       ),
    //     )
    //     .toList();
    // listOfChildren.insert(
    //   0,
    //   new Positioned(
    //     child: CustomPaint(
    //       painter: CurvePainter(),
    //       size: Size(MediaQuery.of(context).size.width,
    //           MediaQuery.of(context).size.height),
    //     ),
    //   ),
    // );
    List<Widget> _segments = [
      Container(
        padding: EdgeInsets.all(5),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Container(
              height: _mediaQuery.size.height * 0.25,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: _mediaQuery.size.width,
                    height: _mediaQuery.size.height * 0.05,
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: Text('placeholder'),
                    ),
                  ),
                  Container(
                    height: _mediaQuery.size.height * 0.20,
                    child: Card(
                      color: Theme.of(context).primaryColorDark,
                      child: Column(
                        children: [
                          Text('placeholder'),
                          Container(
                            height: _mediaQuery.size.height * 0.13,
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Card(
                              color: Theme.of(context).primaryColorLight,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Text('placeholder'),
                                    ),
                                    Container(
                                      child: Text('placeholder'),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                height: _mediaQuery.size.height * 0.40,
                // width: double.infinity,
                //color: Colors.purple,
                child: totalDots.length == 0
                    ? Container()
                    : BlockListView(
                        _bodyWidth,
                        _bodyHeight,
                        totalDots,
                      ),
              ),
            )
          ],
        ),
      ),
      Container(
        child: Center(
          child: Text(
            'Under construction',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      body: _segments[_sharedValue],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(_bodyWidth, 0.05 * _bodyHeight),
          child: CupertinoSegmentedControl<int>(
            padding: EdgeInsets.all(8),
            children: _label,
            onValueChanged: (int val) {
              setState(() {
                _sharedValue = val;
                print('$_sharedValue');
              });
            },
            groupValue: _sharedValue,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: _mediaQuery.size.height * 0.12,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 4, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/asset/Icon/medal.png'),
                  Text('journey'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/asset/Icon/rewards.png'),
                  Text('rewards'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/asset/Icon/exercise.png'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/asset/Icon/challenges.png'),
                  Text('challenges'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/asset/Icon/profile.png'),
                  Text('profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
