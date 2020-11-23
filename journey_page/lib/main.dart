import 'package:flutter/material.dart';
import 'package:journey_page/CurvePainter.dart';
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
  void _incrementCounter() {
    setState(() {});
  }

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
    final _bodyHeight = _mediaQuery.size.height;
    final _bodyWidth = _mediaQuery.size.width;

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
                            height: _mediaQuery.size.height * 0.5,
                            // width: double.infinity,
                            //color: Colors.purple,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Stack(
                                children: [
                                  CustomPaint(
                                    painter: CurvePainter(),
                                    size: Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height),
                                  ),
                                  ListOfWidgets(
                                    new CurvePainter().getDrawingPoints(
                                      MediaQuery.of(context).size.width/1.3,
                                      MediaQuery.of(context).size.height/4,
                                      8,
                                    ),
                                  )
                                ],
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
