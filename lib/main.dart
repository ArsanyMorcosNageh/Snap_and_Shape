import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap_and_shape/core/cache_helper/cache_helper.dart';
import 'package:snap_and_shape/core/widgets/spash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final bool onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
//onboardingCompleted: onboardingCompleted
  CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final bool onboardingCompleted;
  //required this.onboardingCompleted
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snap & Shape',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

        home:  SplashView(),
      //home: onboardingCompleted ? const HomeView() : const OnboardingView(),
    );
  }
}

