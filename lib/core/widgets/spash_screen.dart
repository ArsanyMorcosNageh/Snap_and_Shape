import 'package:flutter/material.dart';
import 'dart:async';
import '../../features/onboarding/presentation/view/onboarding_view.dart';
import '../utils/clip_paths.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late AnimationController _clipController;
  late Animation<Offset> _topClipAnimation;
  late Animation<Offset> _bottomClipAnimation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // تحريك اللوجو
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // تحريك الـ Clips
    _clipController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _topClipAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _clipController, curve: Curves.easeOut));

    _bottomClipAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _clipController, curve: Curves.easeOut));

    // تشغيل الأنيميشن
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
      _logoController.forward();
      _clipController.forward();
    });

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              OnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _clipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Clipper Animation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _topClipAnimation,
              child: ClipPath(
                clipper: TopClipper(),
                child: Container(
                  color: const Color(0xFF670977),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
            ),
          ),
          // Bottom Clipper Animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _bottomClipAnimation,
              child: ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  color: const Color(0xFF670977),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
            ),
          ),
          // Logo Animation
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _opacity,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/App_Icon.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}