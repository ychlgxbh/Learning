import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_course_by_max/quiz.dart';
import 'package:flutter_course_by_max/result.dart';
import './quiz.dart';

// void main() {
//   var app = new MyApp();
//   runApp(app);
// }

// function with only one expression
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _counter = 0;
  var _sumOfScore = 0;

  final _questions = const [
    {
      'questionText': 'What\'s your favourite colour',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 7},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favourite animal',
      'answers': [
        {'text': 'Dog', 'score': 5},
        {'text': 'Cat', 'score': 3},
        {'text': 'Lion', 'score': 10},
        {'text': 'Lamb', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favourite programming language',
      'answers': [
        {'text': 'Python', 'score': 3},
        {'text': 'PHP', 'score': 2},
        {'text': 'Java', 'score': 10},
        {'text': 'C++', 'score': 0},
      ],
    },
  ];

  void _restart() {
    setState(() {
      _sumOfScore = 0;
      _counter = 0;
      _questionIndex = 0;
    });
  }

  void _answerToQuestions(int num) {
    _sumOfScore += num;
    _counter++;
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerToQuestions: _answerToQuestions,
                questionIndex: _questionIndex,
                questions: _questions)
            : Result(
                _sumOfScore,
                _restart,
              ),
      ),
    );
  }
}
