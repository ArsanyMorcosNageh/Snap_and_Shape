// 


// food_recommendation_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../food_items/presentation/view/food_items_view.dart';
import 'dart:math';

class FoodRecommendationView extends StatefulWidget {
  @override
  _FoodRecommendationViewState createState() => _FoodRecommendationViewState();
}

class _FoodRecommendationViewState extends State<FoodRecommendationView> {
  int _selectedCategory = 0;
  final List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];

  final List<FoodItem> allItems = [
    FoodItem(
      name: 'Grilled Chicken with Rice and Vegetables',
      image: 'assets/images/1.png',
      calories: '420 Kcal',
      ingredients: ['Grilled chicken', 'White rice', 'Broccoli', 'Cherry tomatoes', 'Red sauce'],
    ),
    FoodItem(
      name: 'Chickpea Caesar Salad',
      image: 'assets/images/2.png',
      calories: '350 Kcal',
      ingredients: ['Romaine lettuce', 'Kale', 'Roasted chickpeas', 'Croutons', 'Parmesan cheese', 'Caesar dressing'],
    ),
    FoodItem(
      name: 'Salmon Rice Bowl',
      image: 'assets/images/3.png',
      calories: '520 Kcal',
      ingredients: ['Grilled salmon', 'White rice', 'Avocado', 'Cucumber', 'Radish', 'Kimchi', 'Seaweed'],
    ),
    FoodItem(
      name: 'Thai Noodle Bowl',
      image: 'assets/images/4.png',
      calories: '480 Kcal',
      ingredients: ['Rice noodles', 'Ground chicken', 'Red bell pepper', 'Fresh basil', 'Green onions', 'Soy sauce'],
    ),
    FoodItem(
      name: 'Spicy Sesame Noodles',
      image: 'assets/images/5.png',
      calories: '530 Kcal',
      ingredients: ['Hand-pulled noodles', 'Chili oil', 'Sesame sauce', 'Green onions', 'Fresh cilantro', 'Sesame seeds'],
    ),
    FoodItem(
      name: 'White Bean and Kale Stew',
      image: 'assets/images/6.png',
      calories: '390 Kcal',
      ingredients: ['White beans', 'Kale', 'Onions', 'Celery', 'Garlic', 'Vegetable broth', 'Olive oil'],
    ),
    FoodItem(
      name: 'Pasta e Fagioli',
      image: 'assets/images/7.png',
      calories: '440 Kcal',
      ingredients: ['Ditalini pasta', 'Cannellini beans', 'Tomatoes', 'Onions', 'Garlic', 'Carrots', 'Celery', 'Parmesan cheese'],
    ),
    FoodItem(
      name: 'Palak Paneer with Rice',
      image: 'assets/images/8.png',
      calories: '460 Kcal',
      ingredients: ['Paneer cubes', 'Spinach curry', 'Cumin seeds', 'White rice', 'Cream', 'Garlic', 'Ginger'],
    ),
    FoodItem(
      name: 'Lentil and Roasted Sweet Potato Salad',
      image: 'assets/images/9.png',
      calories: '410 Kcal',
      ingredients: ['Green lentils', 'Roasted sweet potatoes', 'Goat cheese', 'Fresh parsley', 'Olive oil', 'Black pepper'],
    ),
    FoodItem(
      name: 'Moroccan Chicken with Olives',
      image: 'assets/images/10.png',
      calories: '480 Kcal',
      ingredients: ['Chicken thighs', 'Green olives', 'Onions', 'Garlic', 'Cilantro', 'Parsley', 'Lemon', 'Spices mix'],
    ),
  ];

  List<FoodItem> _getShuffledItems(String category) {
    final items = [...allItems];
    final seed = category.hashCode;
    items.shuffle(Random(seed));
    return items;
  }

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
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
                    backgroundColor: _selectedCategory == index
                        ? const Color(0xFFF9AB0B)
                        : Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    categories[index],
                    style: GoogleFonts.amaranth(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
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
    final String selectedCategoryName = categories[_selectedCategory];
    final List<FoodItem> items = _getShuffledItems(selectedCategoryName);

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemView(item: item)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.amaranth(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item.calories,
                        style: GoogleFonts.amaranth(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
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