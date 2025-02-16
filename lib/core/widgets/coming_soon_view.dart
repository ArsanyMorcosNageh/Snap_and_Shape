import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ComingSoonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center, // توسيط كل العناصر
        children: [
          Row(
            children: [
              // الجزء الأيسر (بيج)
              Container(
                width: screenWidth * 0.557,
                height: screenHeight,
                color: Color(0xFFFDF8EC),
              ),
              // الجزء الأيمن (بنفسجي)
              Container(
                width: screenWidth * 0.442,
                height: screenHeight,
                color: Color(0xFF5E1675),
              ),
            ],
          ),
          // الأنيميشن في المنتصف
          Positioned(
            left: screenWidth * 0, // لضبط المنتصف
            child: Lottie.asset(
              'assets/images/animation_coming_soon.json',
              width: screenWidth * 1.055, // يظل الأنيميشن في المنتصف
              height: screenHeight * 112,
              fit: BoxFit.contain,
            ),
          ),
          // زر الرجوع في الركن العلوي الأيسر
          Positioned(
            top: screenHeight * 0.07, // 7% من ارتفاع الشاشة
            left: screenWidth * 0.05, // 5% من عرض الشاشة
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
