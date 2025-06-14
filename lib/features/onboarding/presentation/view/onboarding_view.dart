import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_and_shape/features/sign_in/presentation/view/sign_in_view.dart';
import '../../../../core/utils/clip_paths.dart';
import '../../../../core/widgets/user_prefrences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome,\n to Snap & Shape...',
      'description':
          'Scala, track your meals, receive personalized food recommendations, and enjoy tailored exercise plans just for you.',
      'image': 'assets/images/onboarding1.svg',
    },
    {
      'title': 'Smart Food Recognition',
      'description':
          'Snap a photo of your meal, and we will do the rest!\nGet accurate measurements and analyze the quality of your food effortlessly.',
      'image': 'assets/images/onboarding2.svg',
    },
    {
      'title': 'Track Your Progress',
      'description':
          'Keep an eye on your daily calorie intake and track your weight changes!',
      'image': 'assets/images/onboarding3.svg',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _navigateToHome() async {
    await UserPreferences.setOnboardingCompleted(true); // ✅ حفظ الحالة
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignInView(),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopClipper(),
              child: Container(
                color: const Color(0xFF670977),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomClipper(),
              child: Container(
                color: const Color(0xFF670977),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingData[index]['title']!,
                description: onboardingData[index]['description']!,
                image: onboardingData[index]['image']!,
                isLastPage: index == onboardingData.length - 1,
                onGetStarted: _navigateToHome,
                onNext: _nextPage,
                currentPage: _currentPage,
                totalPages: onboardingData.length,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isLastPage;
  final VoidCallback onGetStarted;
  final VoidCallback onNext;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isLastPage,
    required this.onGetStarted,
    required this.onNext,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.amaranth(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                description,
                style: GoogleFonts.amaranth(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: isLastPage ? onGetStarted : onNext,
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
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? const Color(0xFFF9AB0B)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
          ],
        ),
      ],
    );
  }
}
