import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

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
  List<Icon> _scoreKeeper = [];

  void scoreKeeperState({i = Icons.check, c = Colors.red}) {
    setState(() {
      _scoreKeeper.add(Icon(
        //Right answer
        i,
        color: c,
      ));
    });
  }

  void checkAnswer(bool boolChoice) {
    if (quizBrain.isFinished() == true) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "GAME OVER",
        desc: "You answered everything",
        buttons: [
          DialogButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              quizBrain.reset();
              _scoreKeeper = [];
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if (correctAnswer == boolChoice) {
        print('User got it right!');
        scoreKeeperState(i: Icons.check, c: Colors.green);
        quizBrain.nextQuestion();
      } else {
        print('User got it wrong...');
        scoreKeeperState(i: Icons.close, c: Colors.red);
        quizBrain.nextQuestion();
      }
    }
  }
  //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
  //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
  //HINT! Step 4 Part B is in the quiz_brain.dart
  //TODO: Step 4 Part C - reset the questionNumber,
  //TODO: Step 4 Part D - empty out the scoreKeeper.

  //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇

  @override
  Widget build(BuildContext context) {
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
                quizBrain.getQuestionText(),
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
            child: TextButton(
              style: ButtonStyle(
                // textColor: Colors.white,
                // color: Colors.green,
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                // textColor: Colors.white,
                // color: Colors.green,
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        )
      ],
    );
  }
}
