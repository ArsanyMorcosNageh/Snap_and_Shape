import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import '../../../../core/navigation/bottom_navigation_bar.dart';
import '../../../../core/utils/clippers.dart';
import '../../../../core/widgets/user_prefrences.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  final double _buttonWidth = 300;
  final double _buttonHeight = 60;

  Map<String, int> getDynamicRanges(String key) {
    final age = answers['age']?.toInt() ?? 25;
    final currentWeight = answers['current_weight']?.toInt() ?? 70;
    final height = answers['height']?.toInt() ?? 170;
    final gender = answers['gender'] ?? 'Male';

    switch (key) {
      case 'age':
        return {'min': 13, 'max': 100};

      case 'current_weight':
        if (age < 15) {
          return gender == 'Male'
              ? {'min': 30, 'max': 70}
              : {'min': 28, 'max': 65};
        } else if (age < 20) {
          return gender == 'Male'
              ? {'min': 45, 'max': 90}
              : {'min': 40, 'max': 80};
        } else if (age < 65) {
          return gender == 'Male'
              ? {'min': 50, 'max': 120}
              : {'min': 45, 'max': 100};
        } else {
          return {'min': 40, 'max': 90};
        }

      case 'goal_weight':
        final heightM = height / 100;
        final minWeight = (18.5 * pow(heightM, 2)).round().clamp(40, 250);
        final maxWeight = (24.9 * pow(heightM, 2)).round().clamp(50, 250);
        return {'min': minWeight, 'max': maxWeight};

      case 'height':
        if (age < 15) {
          return gender == 'Male'
              ? {'min': 130, 'max': 180}
              : {'min': 125, 'max': 170};
        } else if (age < 20) {
          return gender == 'Male'
              ? {'min': 155, 'max': 200}
              : {'min': 150, 'max': 180};
        } else {
          return gender == 'Male'
              ? {'min': 160, 'max': 210}
              : {'min': 150, 'max': 190};
        }

      default:
        return {'min': 0, 'max': 100};
    }
  }

  final List<Map<String, dynamic>> questions = [
    {
      "type": "choices",
      "question": "What is your gender?",
      "options": ["Male", "Female"],
      "key": "gender",
      "multiSelect": false
    },
    {
      "type": "choices",
      "question": "I am a...",
      "options": ["Standard", "Vegetarian", "Vegan", "Pescatarian", "Gluten-Free"],
      "key": "diet",
      "multiSelect": false
    },
    {
      "type": "choices",
      "question": "Which meals do you usually have?",
      "options": ["Breakfast", "Snack", "Lunch", "Dinner"],
      "key": "meals",
      "multiSelect": true
    },
    {
      "type": "choices",
      "question": "Do you have any chronic diseases?",
      "options": ["Diabetes", "Heart Disease", "Cancer", "Other"],
      "key": "chronic_diseases",
      "multiSelect": true
    },
    {
      "type": "choices",
      "question": "You want to...",
      "options": ["Lose Weight", "Gain Weight", "Stabilize Weight"],
      "key": "goal",
      "multiSelect": false
    },
    {
      "type": "number",
      "question": "What is your age?",
      "key": "age",
      "initialValue": 20,
    },
    {
      "type": "number",
      "question": "What is your current weight? (kg)",
      "key": "current_weight",
      "initialValue": 60,
    },
    {
      "type": "number",
      "question": "What is your goal weight? (kg)",
      "key": "goal_weight",
      "initialValue": 60,
    },
    {
      "type": "number",
      "question": "What is your height? (cm)",
      "key": "height",
      "initialValue": 170,
    },
  ];

  final Map<String, dynamic> answers = {};

  Future<void> _saveAnswersLocally() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_answers', jsonEncode(answers));
  }

  void _adjustCurrentValue(String key) {
    final ranges = getDynamicRanges(key);
    final currentValue = answers[key] ?? questions.firstWhere((q) => q['key'] == key)['initialValue'];

    if (currentValue < ranges['min']!) {
      answers[key] = ranges['min'];
    } else if (currentValue > ranges['max']!) {
      answers[key] = ranges['max'];
    }
  }

  void _goToNextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      await _saveAnswersLocally();
      await UserPreferences.setQuestionnaireCompleted(true); // ✅ تم الإضافة هنا

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final key = currentQuestion["key"];
    if (currentQuestion["type"] == "number") {
      _adjustCurrentValue(key);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ClipPath(
              key: ValueKey<int>(currentQuestionIndex),
              clipper: currentQuestionIndex.isEven ? WaveClipperRight() : WaveClipperLeft(),
              child: Container(
                height: 150,
                color: const Color(0xFF670977),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(currentQuestion["question"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amaranth(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    if (currentQuestion["type"] == "number")
                      _buildNumberPicker(currentQuestion),
                    if (currentQuestion["type"] == "choices")
                      _buildOptions(currentQuestion, currentQuestion["multiSelect"] ?? false),
                    const SizedBox(height: 20),
                    _buildPageIndicators(),
                    const SizedBox(height: 20),
                    _buildNextButton(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPicker(Map<String, dynamic> question) {
    final key = question["key"];
    final ranges = getDynamicRanges(key);
    final unit = _getUnit(key);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          value: answers[key] ?? question["initialValue"],
          minValue: ranges['min']!,
          maxValue: ranges['max']!,
          onChanged: (value) => setState(() => answers[key] = value),
          textStyle: GoogleFonts.amaranth(
            color: const Color(0xFF670977),
            fontSize: 20,
          ),
          selectedTextStyle: GoogleFonts.amaranth(
            color: const Color(0xFFF9AB0B),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          unit,
          style: GoogleFonts.amaranth(
            color: const Color(0xFF670977),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getUnit(String key) {
    if (key.contains("weight")) return "kg";
    if (key == "height") return "cm";
    return "";
  }

  Widget _buildOptions(Map<String, dynamic> question, bool multiSelect) {
    final options = question["options"] as List<String>;
    final key = question["key"];

    return Column(
      children: options.map((option) {
        final selected = multiSelect
            ? (answers[key] as List<String>? ?? []).contains(option)
            : answers[key] == option;

        return GestureDetector(
          onTap: () => setState(() {
            if (multiSelect) {
              final list = List<String>.from(answers[key] ?? []);
              selected ? list.remove(option) : list.add(option);
              answers[key] = list;
            } else {
              answers[key] = option;
            }
          }),
          child: Container(
            width: _buttonWidth,
            height: _buttonHeight,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFF9AB0B) : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? const Color(0xFFF9AB0B) : Colors.grey,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                option,
                style: GoogleFonts.amaranth(
                  color: selected ? Colors.black : Colors.grey[800],
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        questions.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentQuestionIndex == index ? 12 : 8,
          height: currentQuestionIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentQuestionIndex == index
                ? const Color(0xFFF9AB0B)
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final isLastPage = currentQuestionIndex == questions.length - 1;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: _goToNextQuestion,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLastPage
              ? const Color(0xFFF9AB0B)
              : const Color(0xFF670977),
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
    );
  }
}
