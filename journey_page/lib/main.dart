import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:journey_page/CurvePainter.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/dummyRoute.dart';
import 'package:journey_page/iconWidget.dart';
import 'package:journey_page/journeyBlock.dart';
import 'package:journey_page/blockListView.dart';
import 'package:journey_page/userInfo.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

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
        buttonBarTheme: ButtonBarThemeData(
          alignment: MainAxisAlignment.center,
        ),
      ),
      home: MyHomePage(title: 'Journey Page Demo'),
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
  final _cornerRadius = 20.0;
  final Map<int, Widget> _label = <int, Widget>{
    0: Text('          Journey Map          '),
    1: Text('          Activity          '),
  };
  List<Dot> totalDots = [];
  @override
  void initState() {
    super.initState();

    loadAsset().then((value) {
      setState(() {
        print('setState in main is called');
        totalDots = userInfoFromJson(value).dots;
      });
    });
  }

// Transform a json file into a json string
  Future<String> loadAsset() async {
    //print('in loadasset');
    return await rootBundle.loadString('lib/asset/jsons/journeyMap.json');
  }

// Redirecto to a dummy page
  void dummyRoute() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DummyRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _bodyHeight = _mediaQuery.size.height;
    final _bodyWidth = _mediaQuery.size.width;

// Content of different element of the segmented control in body, should be moved
// to an individual file later
    List<Widget> _segments = [
      // Structure of the body part the journey map page
      Container(
        padding: EdgeInsets.only(top: _bodyHeight * 0.01),
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _mediaQuery.size.height * 0.255,
                width: double.infinity,
                child: Column(
                  children: [
                    // space reserved for one-line ads
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

                    // info board
                    Container(
                      padding: EdgeInsets.all(_mediaQuery.size.height * 0.01),
                      height: _mediaQuery.size.height * 0.20,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(_cornerRadius),
                          ),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        child: Column(
                          children: [
                            // Title of the info board
                            Container(
                              height: _mediaQuery.size.height * 0.05,
                              child: Center(
                                child: Text(
                                  'TODAY\'S GOAL',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // Content of the info board
                            Container(
                              height: _mediaQuery.size.height * 0.13,
                              padding: EdgeInsets.fromLTRB(
                                _bodyWidth * 0.02,
                                _bodyHeight * 0.01,
                                _bodyWidth * 0.02,
                                _bodyHeight * 0.01,
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height:
                                              _mediaQuery.size.height * 0.12,
                                          width: _mediaQuery.size.width * 0.43,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  _cornerRadius),
                                              bottomLeft: Radius.circular(
                                                  _cornerRadius),
                                            ),
                                            color: Color(0xFF53ABCF),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'COMPLETED',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                                Text(
                                                  '0 OF 50',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'REPS',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: _mediaQuery.size.width * 0.01,
                                        ),
                                        Container(
                                          height:
                                              _mediaQuery.size.height * 0.115,
                                          width: _mediaQuery.size.width * 0.43,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  _cornerRadius),
                                              bottomRight: Radius.circular(
                                                  _cornerRadius),
                                            ),
                                            color: Color(0xFF53ABCF),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'EARN',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'COINS',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                  Center(
                                    child: CircleAvatar(
                                      radius: _mediaQuery.size.width * 0.03,
                                      backgroundColor:
                                          Theme.of(context).primaryColorDark,
                                      child: Text(
                                        '=',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Space to show the journey map
              Container(
                child: Container(
                  padding: EdgeInsets.only(
                    top: _bodyHeight * 0.02,
                  ),
                  height: totalDots.length == 0
                      ? 0.45 * _bodyHeight
                      : (totalDots.length ~/ 12 + 1) * _bodyHeight / 2.81,
              
              //Should be removed in actual app as the loading happens at the start
                  child: totalDots.length == 0
                      ? CupertinoActivityIndicator(
                          radius: 40,
                        )
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
      ),

      // The activity page, not yet built
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
      // Implementation of the appBar
      // Should be moved to an individual file
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
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(60.0),
            )),
            child: SizedBox(
              width: 0.95 * _bodyWidth,
              child: Container(
                padding: EdgeInsets.all(_bodyHeight * 0.015),
                child: MaterialSegmentedControl(
                  verticalOffset: 0.0,
                  children: _label,
                  selectionIndex: _sharedValue,
                  onSegmentChosen: (int value) {
                    setState(() {
                      _sharedValue = value;
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor,
                  unselectedColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),

      // Implementation of the bottom nav bar
      // Should be moved to an individual file
      bottomNavigationBar: Container(
        height: _mediaQuery.size.height * 0.08,
        child: Container(
          color: Colors.white,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(_bodyWidth * 0.02, 0, _bodyWidth * 0.02, 0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    dummyRoute();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/asset/Icon/medal.png'),
                      Text('journey'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    dummyRoute();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/asset/Icon/rewards.png'),
                      Text('rewards'),
                    ],
                  ),
                ),
                Column(),
                GestureDetector(
                  onTap: () {
                    dummyRoute();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/asset/Icon/challenges.png'),
                      Text('challenges'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    dummyRoute();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/asset/Icon/profile.png'),
                      Text('profile'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.1, 1.17),
        child: SizedBox(
          width: 0.11 * _bodyHeight,
          height: 0.11 * _bodyHeight,
          child: RawMaterialButton(
            elevation: 0.0,
            disabledElevation: 0.0,
            focusElevation: 0.0,
            highlightElevation: 0.0,
            hoverElevation: 0.0,
            onPressed: () {
              dummyRoute();
            },
            fillColor: Colors.white,
            padding: EdgeInsets.all(0.006 * _bodyHeight),
            shape: CircleBorder(),
            child: Image.asset('lib/asset/Icon/exercise@2x.png'),
          ),
        ),
      ),
    );
  }
}
