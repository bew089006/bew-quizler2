import 'dart:ffi';

import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static Icon checkIcon = Icon(
    Icons.check,
    color: Colors.green,
  );
  static Icon closeIcon = Icon(
    Icons.close,
    color: Colors.red,
  );

  List<Widget> scoreKeeper = [];
  List<Question> questions = [
    Question(
        questionText: 'You can lead a cow down stairs but not up stairs.',
        answer: false),
    Question(
        questionText:
            'Approximately one quarter of human bones are in the feet.',
        answer: true),
    Question(questionText: 'A slug\'s blood is green.', answer: true)
  ];

  void checkAnswer(index, answer) {
    if (questions[index].answer == answer) {
      scoreKeeper.add(checkIcon);
    } else {
      scoreKeeper.add(closeIcon);
    }
  }

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    if (questionNumber < questions.length) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questions[questionNumber].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAnswer(questionNumber, true);
                    questionNumber++;
                  });
                  //The user picked true.
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAnswer(questionNumber, false);
                    questionNumber++;
                  });
                  //The user picked false.
                },
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Finished',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'Your answers',
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                questionNumber = 0;
                scoreKeeper = [];
              });
            },
            child: Text(
              'return to first question',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.blue,
          ),
        ],
      );
    }
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
