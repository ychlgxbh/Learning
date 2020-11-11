import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int total;
  final Function restart;


  Result(this.total, this.restart);

  String get resultText {
    String text = "ok";
    if(total > 10){
      text = 'nice!';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Center(
        child: Text('Your total score is $total. $resultText'),
      ),
      FlatButton(
        onPressed: restart,
        child: Text('Try again!'),
        hoverColor: Colors.blue,
        focusColor: Colors.blueGrey,
        color: Colors.blueAccent,
      )
    ]);
  }
}
