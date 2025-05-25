import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  List<double> predictedWeights = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPredictedWeights();
  }

  Future<void> fetchPredictedWeights() async {
    try {
      final response = await http.get(
        Uri.parse("http://graduationproject-apis.runasp.net/api/AiModel/predict-weight"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> weights = data["predicted_weight"];
        setState(() {
          predictedWeights = weights.map((w) => double.parse(w.toString())).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:  Text(
          'Predicted Weights',
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
          iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF670977),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text("Error loading data."))
              : ListView.builder(
                  itemCount: predictedWeights.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFF9AB0B),
                        child: Text("D${index + 1}", style: TextStyle(color: Colors.white)),
                      ),
                      title: Text("Predicted Weight: ${predictedWeights[index].toStringAsFixed(2)} kg"),
                    );
                  },
                ),
    );
  }
}
