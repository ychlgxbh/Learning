import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz  extends StatelessWidget {
  
  final Function answerToQuestions;
  final List <Map<String, Object>> questions;
  final int questionIndex;

  Quiz({@required this.answerToQuestions, @required this.questionIndex, @ required this.questions,});

  @override
  Widget build(BuildContext context) {
    return Column(
                children: <Widget>[
                  Question(
                    questions[questionIndex]['questionText'],
                  ),
                  ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
                      .map((answer) {
                    return Answer(() => answerToQuestions(answer['score']), answer['text']);
                  }),
                ],
              );
  }
}