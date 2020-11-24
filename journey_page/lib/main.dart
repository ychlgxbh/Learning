import 'package:flutter/material.dart';
import 'package:journey_page/CurvePainter.dart';
import 'package:journey_page/drawingPoint.dart';
import 'package:journey_page/iconWidget.dart';
import 'package:journey_page/listOfWidgets.dart';

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
  GlobalKey _key = GlobalKey();

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
    final _bodyHeight = _mediaQuery.size.height ;
    final _bodyWidth = (_mediaQuery.size.width-20) ;

    return DefaultTabController(
      length: _selectionTabs.length,
      child: Scaffold(
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
          bottom: TabBar(
            tabs: _selectionTabs,
            labelColor: Colors.black,
            
          ),
        ),
        body: TabBarView(
          children: _selectionTabs.map((Tab tab) {
            final List<DrawingPoint> _drawingPoint = new CurvePainter()
                .getDrawingPoints(_bodyWidth, _bodyHeight, 16);
            final listOfChildren = _drawingPoint
                .map(
                  (e) => Positioned(
                    left: e.currentX,
                    top: e.currentY,
                    child: IconWidget(e.index),
                  ),
                )
                .toList();
            listOfChildren.insert(
              0,
              new Positioned(
                child: CustomPaint(
                  painter: CurvePainter(),
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                ),
              ),
            );
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
                          height: _mediaQuery.size.height * 0.15,
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
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: _mediaQuery.size.height * 0.55,
                            // width: double.infinity,
                            //color: Colors.purple,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Stack(
                                children: listOfChildren,
                              ),
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
