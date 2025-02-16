// food_recommendation_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../food_items/presentation/view/food_items_view.dart';

class FoodRecommendationView extends StatefulWidget {
  @override
  _FoodRecommendationViewState createState() => _FoodRecommendationViewState();
}

class _FoodRecommendationViewState extends State<FoodRecommendationView> {
  int _selectedCategory = 1; // Default to Lunch
  final List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];

  void _selectCategory(int index) {
    setState(() {
      _selectedCategory = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: const Color(0xFF670977),

            appBar: AppBar(
        automaticallyImplyLeading: false,
        
  backgroundColor: const Color(0xFF670977),
          title: Text(
          'Recommended Food',
          style: GoogleFonts.amaranth(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                  // centerTitle: true,
        // elevation: 0,
        ),
      
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(categories.length, (index) {
                return ElevatedButton(
                  onPressed: () => _selectCategory(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedCategory == index ?  Color(0xFFF9AB0B) : Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(categories[index], style: GoogleFonts.amaranth(color: Colors.black,fontWeight: FontWeight.bold, fontSize:14),),
                );
              }),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: _buildFoodGrid(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: 6, // Assume fetched from backend
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemView()),
          ),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Image.asset('assets/images/food.png', height: 100,width: 100, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text('Sandwich',  style: GoogleFonts.amaranth(color: Colors.black,fontWeight: FontWeight.bold, fontSize:14),),
                      Text('340 Kcal', style: GoogleFonts.amaranth(color: Color(0xFF670977), fontSize:14),),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color(0xFFF9AB0B),

                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 36),
                        ),
                        child: Text('Add to list', style: GoogleFonts.amaranth(color: Colors.black,fontWeight: FontWeight.bold, fontSize:14),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}