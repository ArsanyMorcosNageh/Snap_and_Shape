import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodScanScreen extends StatelessWidget {
  final List<Map<String, dynamic>> scannedItems;

  const FoodScanScreen({super.key, required this.scannedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
        

 Text(
          'Scanned Items',
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),



        backgroundColor: const Color(0xFF670977),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: scannedItems.isEmpty
            ? Center(
                child: Text(
                  "No data found.",
                  style: GoogleFonts.amaranth(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: scannedItems.length,
                itemBuilder: (context, index) {
                  final item = scannedItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['type'].toString().toUpperCase(),
                          style: GoogleFonts.amaranth(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF670977),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Position: ${item['position']}", style: const TextStyle(fontSize: 16)),
                        Text("Freshness: ${item['freshness']}", style: const TextStyle(fontSize: 16)),
                        Text("Weight: ${item['weight_grams']} g", style: const TextStyle(fontSize: 16)),
                        Text("Calories: ${item['calories']} Kcal", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}