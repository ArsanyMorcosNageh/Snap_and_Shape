import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseRecommendationView extends StatefulWidget {
  @override
  _ExerciseRecommendationViewState createState() => _ExerciseRecommendationViewState();
}

class _ExerciseRecommendationViewState extends State<ExerciseRecommendationView> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double _currentPage = 0;
  
  final List<Map<String, dynamic>> exerciseCards = [
    {
      'title': 'Weight Loss',
      'type': 'Full body workout',
      'duration': '15 Min', 
      'calories': '300 kcal',
      'color': Color(0xFFF9AB0B),
    },
    {
      'title': 'Strength Training', 
      'type': 'Full body workout',
      'duration': '20 Min',
      'calories': '450 kcal',
      'color': Color(0xFF670977),
    },
    {
      'title': 'HIIT Workout',
      'type': 'High Intensity',
      'duration': '25 Min',
      'calories': '500 kcal', 
      'color': Color(0xFF1E88E5),
    }
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'UPPER BODY',
      'subtitle': 'Biceps - Triceps - Shoulders',
      'duration': '20 Min',
      'calories': '450 Kcal',
    },
    {
      'title': 'ABS',
      'subtitle': 'Stomach - Sides',
      'duration': '40 Min', 
      'calories': '460 Kcal',
    },
    {
      'title': 'LEGS',
      'subtitle': 'Inside - Outside - Nip Dip',
      'duration': '30 Min',
      'calories': '480 Kcal',
    },
    {
      'title': 'CHEST & BACK',
      'subtitle': 'Chest - Back muscles',
      'duration': '20 Min',
      'calories': '450 Kcal',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF670977),
        title: Text(
          'Hello Arsany',
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            height: 280,
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
                  child: _buildExerciseCard(exerciseCards[index], difference),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: categories.length,
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemBuilder: (context, index) => _buildCategoryItem(categories[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> card, double difference) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 20,
        left: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: card['color'].withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                card['color'].withOpacity(0.1),
                card['color'].withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card['title'],
                style: GoogleFonts.amaranth(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: card['color'],
                ),
              ),
              SizedBox(height: 10),
              Text(
                card['type'],
                style: GoogleFonts.amaranth(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: card['color'], size: 20),
                          SizedBox(width: 5),
                          Text(
                            card['duration'],
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: card['color'],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.grey[600], size: 20),
                          SizedBox(width: 5),
                          Text(
                            card['calories'],
                            style: GoogleFonts.amaranth(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: card['color'],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      elevation: 8,
                    ),
                    onPressed: () {},
                    child: Text(
                      'START',
                      style: GoogleFonts.amaranth(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['title'],
                    style: GoogleFonts.amaranth(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF670977),
                    ),
                  ),
                  SizedBox(height: 5),
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
              children: [
                Text(
                  category['duration'],
                  style: GoogleFonts.amaranth(
                    fontSize: 16,
                    color: const Color(0xFFF9AB0B),
                  ),
                ),
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
      ),
    );
  }
}
