import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../core/navigation/bottom_navigation_bar.dart';
import '../../../../core/utils/clippers.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.9,
      size.width * 0.5,
      size.height * 0.8,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width,
      size.height * 0.8,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  final double _buttonWidth = 300;
  final double _buttonHeight = 60;
 // final double _imageSize = 70;

  final List<Map<String, dynamic>> questions = [
    {"type": "choices", "question": "What is your gender?", "options": ["Male", "Female"], "key": "gender", "multiSelect": false},
    {"type": "choices", "question": "I am a...", "options": ["Standard", "Vegetarian", "Vegan", "Pescatarian", "Gluten-Free"], "key": "diet", "multiSelect": false},
    {"type": "choices", "question": "Which meals do you usually have?", "options": ["Breakfast", "Snack", "Lunch", "Dinner"], "key": "meals", "multiSelect": true},
    {"type": "choices", "question": "Do you have any chronic diseases?", "options": ["Diabetes", "Heart Disease", "Cancer", "Other"], "key": "chronic_diseases", "multiSelect": true},
    {"type": "choices", "question": "You want to...", "options": ["Lose Weight", "Gain Weight", "Stabilize Weight"], "key": "goal", "multiSelect": false},
    {"type": "number", "question": "What is your age?", "minValue": 10, "maxValue": 100, "initialValue": 25, "key": "age"},
    {"type": "number", "question": "What is your current weight?", "minValue": 40, "maxValue": 200, "initialValue": 70, "key": "current_weight"},
    {"type": "number", "question": "What is your goal weight?", "minValue": 40, "maxValue": 200, "initialValue": 60, "key": "goal_weight"},
    {"type": "number", "question": "What is your height?", "minValue": 150, "maxValue": 300, "initialValue": 170, "key": "height"},
  ];

  final Map<String, dynamic> answers = {};

  Future<void> _saveAnswersLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAnswers = jsonEncode(answers);
    await prefs.setString('user_answers', encodedAnswers);
  }

  void _goToNextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      await _saveAnswersLocally();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    String questionText = currentQuestion["question"];
    String questionType = currentQuestion["type"];
    String key = currentQuestion["key"];
    bool multiSelect = currentQuestion["multiSelect"] ?? false;
    bool isLastPage = currentQuestionIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [AnimatedSwitcher(
  duration: const Duration(milliseconds: 300), // سرعة التغيير
  transitionBuilder: (Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
  child: ClipPath(
    key: ValueKey<int>(currentQuestionIndex), // لازم نغير الـ Key علشان يحصل الأنيميشن
    clipper: currentQuestionIndex.isEven ? WaveClipperRight() : WaveClipperLeft(),
    child: Container(
      height: 150,
      color: const Color(0xFF670977),
    ),
  ),
),
          Column(
            children: [
              SizedBox(height:MediaQuery.of(context).size.height * 0.3),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(questionText, 
                        style: GoogleFonts.amaranth(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                        )),
                    const SizedBox(height: 20),
                    if (questionType == "number") ...[
                      NumberPicker(
                        value: answers[key] ?? currentQuestion["initialValue"],
                        minValue: currentQuestion["minValue"],
                        maxValue: currentQuestion["maxValue"],
                        onChanged: (value) {
                          setState(() {
                            answers[key] = value;
                          });
                        },
                      ),
                    ] else if (questionType == "choices") ...[
                      Column(
                        children: currentQuestion["options"].map<Widget>((option) {
                          bool isSelected = multiSelect
                              ? (answers[key] ?? []).contains(option)
                              : answers[key] == option;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (multiSelect) {
                                  if (isSelected) {
                                    (answers[key] ?? []).remove(option);
                                  } else {
                                    answers[key] = (answers[key] ?? [])..add(option);
                                  }
                                } else {
                                  answers[key] = option;
                                }
                              });
                            },
                            child: Container(
                              width: _buttonWidth,
                              height: _buttonHeight,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFF9AB0B) : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFF9AB0B) : Colors.grey, 
                                  width: 2
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  option,
                                  style: GoogleFonts.amaranth(
                                    color: isSelected ? Colors.black : Colors.grey[900],
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: _goToNextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLastPage ? const Color(0xFFF9AB0B) : const Color(0xFF670977),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          isLastPage ? 'Get Started' : 'Next',
                          style: GoogleFonts.amaranth(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






// SharedPreferences prefs = await SharedPreferences.getInstance();
// String? userAnswers = prefs.getString('user_answers');
// if (userAnswers != null) {
//   Map<String, dynamic> answers = jsonDecode(userAnswers);
//   print(answers);
// }