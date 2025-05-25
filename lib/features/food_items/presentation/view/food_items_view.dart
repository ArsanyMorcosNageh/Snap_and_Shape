// import 'package:flutter/material.dart';

// class ItemView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chicken Tacos')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/food.png', height: 200, width: double.infinity, fit: BoxFit.cover),
//             SizedBox(height: 16),
//             Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text('- Chicken\n- Tortilla bread\n- Vegetables\n- Cheese'),
//             SizedBox(height: 16),
//             Text('Meal details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Center(
//               child: Column(
//                 children: [
//                   Text('340 Kcal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   Image.asset('assets/images/food.png', height: 150),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// item_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItem {
  final String name;
  final String image;
  final String calories;
  final List<String> ingredients;

  FoodItem({
    required this.name,
    required this.image,
    required this.calories,
    required this.ingredients,
  });
}

class ItemView extends StatelessWidget {
  final FoodItem item;

  const ItemView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF670977),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          item.name,
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Ingredients',
                style: GoogleFonts.amaranth(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF670977),
                ),
              ),
              SizedBox(height: 10),
              ...item.ingredients.map((i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '• $i',
                      style: GoogleFonts.amaranth(fontSize: 16),
                    ),
                  )),
              SizedBox(height: 24),
              Text(
                'Total Calories',
                style: GoogleFonts.amaranth(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF670977),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  item.calories,
                  style: GoogleFonts.amaranth(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}