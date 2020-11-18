import 'package:flutter/material.dart';
import 'package:journey_page/CurvePainter.dart';
import 'package:journey_page/flowCurve.dart';
import 'package:journey_page/iconPosition.dart';

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
  void _incrementCounter() {
    setState(() {});
  }

  final List<Tab> _selectionTabs = <Tab>[
    Tab(
      text: 'Journey Map',
    ),
    Tab(
      text: 'Activity',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _bodyHeight = _mediaQuery.size.height;
    final _bodyWidth = _mediaQuery.size.width;
    List<IconPosition> iconPosition = [];

    final _curvePainter = CurvePainter(iconPosition);
    iconPosition = _curvePainter.generateIconPosition(
      Size(17*_bodyWidth/20, 0.35*_bodyHeight),
    );
    return DefaultTabController(
      length: _selectionTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(tabs: _selectionTabs),
        ),
        body: TabBarView(
          children: _selectionTabs.map((Tab tab) {
            return tab.text == 'Activity'
                ? Container(
                    child: Text('Nothing yet'),
                  )
                : Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Container(
                          height: _mediaQuery.size.height * 0.2,
                          width: double.infinity,
                          child: Container(
                            child: Card(
                              color: Theme.of(context).primaryColorDark,
                              child: Column(
                                children: [
                                  Text('Today\s goal'),
                                  Expanded(
                                    child: Card(
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: _mediaQuery.size.height * 0.5,
                            width: _mediaQuery.size.width,
                            // width: double.infinity,
                            //color: Colors.purple,
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: _curvePainter,
                                  size: Size(_bodyWidth, _bodyHeight),
                                 // child: Text('test'),
                                ),
                                FlowCurve(40, iconPosition),
                                // Column(
                                //   children: [
                                //     Text(iconPosition[1].x.toString()),
                                //     Text(iconPosition[1].y.toString()),
                                //     Text(iconPosition[2].x.toString()),
                                //     Text(iconPosition[2].y.toString()),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }).toList(),
        ),
      ),
    );
  }
}
