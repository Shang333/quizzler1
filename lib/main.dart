import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<String> questions = ['問題一', '問題二', '問題三'];
  List<bool> answers = [true, true, false];
  int questionNum = 0;

  void checkAnswer(bool answer) {
    if (questionNum < questions.length - 1) {
      if (questionBank[questionNum].answer == answer) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    } else {
      scoreKeeper = [];
    }
    if (questionNum == questions.length - 1) {
      Alert(
        context: context,
        //type: AlertType.info,
        title: "Finished!",
        desc: "You've reached the end of the quiz.",
        image: Image.asset("assets/success.png"),
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => setState(() {
              questionNum = 0;
            }),
            width: 120,
          )
        ],
      ).show();
    } else {
      setState(() {
        questionNum++;
      });
    }
  }

  List<Question> questionBank = [
    Question(text: '問題一', answer: true),
    Question(text: '問題二', answer: false),
    Question(text: '問題三', answer: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionNum],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.green),
              ),
              child: const Text(
                '是',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => checkAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              child: const Text(
                '否',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => checkAnswer(false),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
