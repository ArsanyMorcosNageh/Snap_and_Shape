
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snap_and_shape/features/home/presentation/view/home_view.dart';

import '../../features/exercise_recommendation/presentation/view/exercise_recommendation_view.dart';
import '../../features/food_recommendation/presentation/view/food_recommendation_view.dart';
import '../../features/profile/presentation/view/profile_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainView> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeView(),
    FoodRecommendationView(),
    ExerciseRecommendationView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFF670977),
        animationDuration: Duration(milliseconds: 400),
        height: 60,
        items: [
          SvgPicture.asset('assets/images/home.svg', width: 26, height:26),
          SvgPicture.asset('assets/images/dish.svg', width: 25, height: 25),
          SvgPicture.asset('assets/images/dumbbell.svg', width: 25, height: 25),
          SvgPicture.asset('assets/images/profile.svg', width: 25, height: 25),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}