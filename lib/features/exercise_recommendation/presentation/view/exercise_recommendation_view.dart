import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseRecommendationView extends StatefulWidget {
  @override
  _ExerciseRecommendationViewState createState() =>
      _ExerciseRecommendationViewState();
}

class _ExerciseRecommendationViewState extends State<ExerciseRecommendationView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double _currentPage = 0;

  final List<Map<String, dynamic>> exerciseCards = [
    {
      'title': 'Weight Loss Training',
      'type': 'Full body Cardio',
      'duration': '15 Min',
      'calories': '300 kcal',
      'color': Color(0xFFF9AB0B),
      'image': 'assets/images/weight_loss.png'
    },
    {
      'title': 'Warm UP',
      'type': 'Full body Warm up',
      'duration': '20 Min',
      'calories': '450 kcal',
      'color': Color(0xFF670977),
      'image': 'assets/images/warm_up.png'
    },
    {
      'title': 'Stretching Exercises',
      'type': 'Full body stretching',
      'duration': '25 Min',
      'calories': '500 kcal',
      'color': Color(0xFF1E88E5),
      'image': 'assets/images/stretching.png'
    }
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'UPPER BODY',
      'subtitle': 'Biceps - Triceps - Shoulders',
      'duration': '20 Min',
      'calories': '450 Kcal',
      'image': 'assets/images/upper_body.png'
    },
    {
      'title': 'ABS',
      'subtitle': 'Stomach - Sides',
      'duration': '40 Min',
      'calories': '460 Kcal',
      'image': 'assets/images/abs.png'
    },
    {
      'title': 'LEGS',
      'subtitle': 'Inside - Outside - Nip Dip',
      'duration': '30 Min',
      'calories': '480 Kcal',
      'image': 'assets/images/legs.png'
    },
    {
      'title': 'CHEST & BACK',
      'subtitle': 'Chest - Back muscles',
      'duration': '20 Min',
      'calories': '450 Kcal',
      'image': 'assets/images/chest_and_back.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: 0,
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final cardHeight = screenHeight * 0.25;
    final categoryHeight = screenHeight * 0.12;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF670977),
          title: Text(
            'Exercise Recommendation',
            style: GoogleFonts.amaranth(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          SizedBox(
            height: cardHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: exerciseCards.length,
              itemBuilder: (context, index) {
                double difference = index - _currentPage;
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(difference * -0.4)
                    ..scale(1 - (difference.abs() * 0.2).clamp(0.0, 0.3)),
                  child: _buildExerciseCard(
                    exerciseCards[index],
                    difference,
                    cardHeight,
                    screenWidth,
                    screenHeight,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              itemCount: categories.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: screenHeight * 0.015),
              itemBuilder: (context, index) => _buildCategoryItem(
                categories[index],
                categoryHeight,
                screenWidth,
                screenHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
    Map<String, dynamic> card,
    double difference,
    double height,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: card['color'].withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card['title'],
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: card['color'],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            card['type'],
                            style: GoogleFonts.amaranth(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer,
                                  size: 20, color: card['color']),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                card['duration'],
                                style: GoogleFonts.amaranth(
                                  fontSize: 16,
                                  color: card['color'],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Row(
                            children: [
                              Icon(Icons.local_fire_department,
                                  size: 20, color: card['color']),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                card['calories'],
                                style: GoogleFonts.amaranth(
                                  fontSize: 16,
                                  color: card['color'],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  child: Image.asset(
                    card['image'],
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    Map<String, dynamic> category,
    double height,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage(category['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category['title'],
                          style: GoogleFonts.amaranth(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF670977),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          category['subtitle'],
                          style: GoogleFonts.amaranth(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer,
                              size: 18,
                              color: const Color(0xFFF9AB0B)),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            category['duration'],
                            style: GoogleFonts.amaranth(
                              fontSize: 14,
                              color: const Color(0xFFF9AB0B),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              size: 18,
                              color: Colors.grey[600]),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            category['calories'],
                            style: GoogleFonts.amaranth(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
