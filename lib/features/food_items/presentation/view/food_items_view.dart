import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chicken Tacos')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/food.png', height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('- Chicken\n- Tortilla bread\n- Vegetables\n- Cheese'),
            SizedBox(height: 16),
            Text('Meal details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text('340 Kcal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Image.asset('assets/images/food.png', height: 150),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
