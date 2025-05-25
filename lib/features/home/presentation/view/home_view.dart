

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// import 'widgets/PredictionScreen.dart';
// import 'widgets/FoodScanScreen.dart';

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int calorieCount = 1700;

//   Map<String, bool> mealExpansionStates = {
//     'Breakfast': false,
//     'Snacks': false,
//         'Dinner': false,
//     'Lunch': false,

//   };

//   Map<String, List<String>> detectedMeals = {
//     'Breakfast': [],
//     'Snacks': [],
//         'Dinner': [],
//     'Lunch': [],

//   };

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xFF670977),
//         title: Text(
//           'My Progress',
//           style: GoogleFonts.amaranth(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.02),
//             _buildCalorieMeter(screenHeight),
//             SizedBox(height: screenHeight * 0.02),
//             _buildActionButtons(),
//             SizedBox(height: screenHeight * 0.02),
//             _buildExpandableMealSection('Breakfast', 300, 450),
//             _buildExpandableMealSection('Snacks', 120, 130),
//             _buildExpandableMealSection(' Dinner', 600, 400),
//             _buildExpandableMealSection('Lunch', 380, 0),
//             SizedBox(height: screenHeight * 0.03),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalorieMeter(double screenHeight) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
//       padding: EdgeInsets.all(screenHeight * 0.02),
//       decoration: BoxDecoration(
//         color: const Color(0xFF670977),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(height: screenHeight * 0.01),
//           Text(
//             'Calories Consumed',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.amaranth(
//               fontSize: screenHeight * 0.025,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.03),
//           TweenAnimationBuilder<int>(
//             tween: IntTween(begin: 0, end: calorieCount),
//             duration: Duration(seconds: 2),
//             builder: (context, value, child) {
//               Color meterColor = _getMeterColor(value);
//               double meterValue = _getMeterValue(value);

//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: screenHeight * 0.2,
//                     height: screenHeight * 0.2,
//                     child: CircularProgressIndicator(
//                       value: meterValue,
//                       color: meterColor,
//                       backgroundColor: Colors.grey[300],
//                       strokeWidth: 15,
//                     ),
//                   ),
//                   Text(
//                     '$value',
//                     style: GoogleFonts.amaranth(
//                       fontSize: screenHeight * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: meterColor,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           SizedBox(height: screenHeight * 0.03),
//         ],
//       ),
//     );
//   }

//   Color _getMeterColor(int calories) {
//     if (calories <= 1000) return Color.fromARGB(255, 15, 220, 22);
//     if (calories <= 2000) return Color(0xFFF9AB0B);
//     return Color.fromARGB(255, 222, 22, 8);
//   }

//   double _getMeterValue(int calories) {
//     return (calories <= 3000) ? calories / 3000 : 1.0;
//   }

//   Widget _buildActionButtons() {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildCustomButton(
//             'Analysis',
//             Color(0xFFF9AB0B),
//             Icons.analytics,
//             constraints.maxWidth * 0.4,
//             () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PredictionScreen()),
//               );
//             },
//           ),
//           _buildCustomButton(
//             'Camera',
//             Color(0xFFF9AB0B),
//             Icons.camera_alt,
//             constraints.maxWidth * 0.4,
//             () {
//               _showImageSourceOptions();
//             },
//           ),
//         ],
//       );
//     });
//   }

//   Widget _buildCustomButton(String label, Color color, IconData icon,
//       double width, VoidCallback onPressed) {
//     return SizedBox(
//       width: width,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 15),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Flexible(
//               child: Text(
//                 label,
//                 style: GoogleFonts.amaranth(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpandableMealSection(
//       String mealType, int suggestedCalories, int consumedCalories) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 mealExpansionStates[mealType] = !mealExpansionStates[mealType]!;
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF9AB0B).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     mealType,
//                     style: GoogleFonts.amaranth(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFF670977),
//                     ),
//                   ),
//                   Icon(
//                     mealExpansionStates[mealType]!
//                         ? Icons.arrow_drop_up
//                         : Icons.arrow_drop_down,
//                     color: const Color(0xFF670977),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             height: mealExpansionStates[mealType]! ? null : 0,
//             child: SingleChildScrollView(
//               physics: NeverScrollableScrollPhysics(),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$suggestedCalories Kcal suggested',
//                       style: GoogleFonts.amaranth(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       '$consumedCalories Kcal',
//                       style: GoogleFonts.amaranth(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF670977),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildMealButton('Scan Meal', Icons.camera_alt, () {
//                           _showImageSourceOptions(mealType);
//                         }),
//                       ],
//                     ),
//                     if (detectedMeals[mealType]!.isNotEmpty)
//                       ...detectedMeals[mealType]!.map((item) => Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.check_circle_outline,
//                                     size: 16, color: Colors.green),
//                                 SizedBox(width: 8),
//                                 Text(item,
//                                     style: GoogleFonts.amaranth(fontSize: 16)),
//                               ],
//                             ),
//                           )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMealButton(String label, IconData icon, VoidCallback onPressed) {
//     return Flexible(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF9AB0B),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Flexible(
//               child: Text(
//                 label,
//                 style: GoogleFonts.amaranth(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showImageSourceOptions([String? mealType]) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.camera_alt),
//             title: Text('Take a Photo'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUploadImage(ImageSource.camera, mealType);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.photo_library),
//             title: Text('Choose from Gallery'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUploadImage(ImageSource.gallery, mealType);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _pickAndUploadImage(ImageSource source, [String? mealType]) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile == null) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             "http://graduationproject-apis.runasp.net/api/FoodDetection/detect"),
//       );
//       request.files
//           .add(await http.MultipartFile.fromPath('File', pickedFile.path));

//       var response = await request.send();

//       Navigator.of(context).pop();

//       if (response.statusCode == 200) {
//         final resString = await response.stream.bytesToString();
//         final jsonData = json.decode(resString);

//         final List<String> detectedObjects =
//             List<String>.from(jsonData['detected_objects']);
//         final List<String> freshnessStatus =
//             List<String>.from(jsonData['freshness_status']);

//         if (mealType != null) {
//           setState(() {
//             detectedMeals[mealType]!.addAll(detectedObjects);
//             detectedMeals[mealType]!.addAll(freshnessStatus);
//           });
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => FoodScanScreen(
//                 detectedObjects: detectedObjects,
//                 freshnessStatus: freshnessStatus,
//               ),
//             ),
//           );
//         }
//       } else {
//         _showErrorDialog();
//       }
//     } catch (e) {
//       Navigator.of(context).pop();
//       _showErrorDialog();
//     }
//   }

//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Failed to upload or process the image.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
// }





// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// import 'widgets/PredictionScreen.dart';
// import 'widgets/FoodScanScreen.dart';

// extension StringCasingExtension on String {
//   String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
// }

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int calorieCount = 0;

//   Map<String, bool> mealExpansionStates = {
//     'Breakfast': false,
//     'Snacks': false,
//     'Dinner': false,
//     'Lunch': false,
//   };

//   Map<String, List<String>> detectedMeals = {
//     'Breakfast': [],
//     'Snacks': [],
//     'Dinner': [],
//     'Lunch': [],
//   };

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xFF670977),
//         title: Text(
//           'My Progress',
//           style: GoogleFonts.amaranth(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.02),
//             _buildCalorieMeter(screenHeight),
//             SizedBox(height: screenHeight * 0.02),
//             _buildActionButtons(),
//             SizedBox(height: screenHeight * 0.02),
//             _buildExpandableMealSection('Breakfast', 300),
//             _buildExpandableMealSection('Snacks', 120),
//             _buildExpandableMealSection('Dinner', 600),
//             _buildExpandableMealSection('Lunch', 380),
//             SizedBox(height: screenHeight * 0.03),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalorieMeter(double screenHeight) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
//       padding: EdgeInsets.all(screenHeight * 0.02),
//       decoration: BoxDecoration(
//         color: const Color(0xFF670977),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(height: screenHeight * 0.01),
//           Text(
//             'Calories Consumed',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.amaranth(
//               fontSize: screenHeight * 0.025,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.03),
//           TweenAnimationBuilder<int>(
//             tween: IntTween(begin: 0, end: calorieCount),
//             duration: Duration(seconds: 2),
//             builder: (context, value, child) {
//               Color meterColor = _getMeterColor(value);
//               double meterValue = _getMeterValue(value);

//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: screenHeight * 0.2,
//                     height: screenHeight * 0.2,
//                     child: CircularProgressIndicator(
//                       value: meterValue,
//                       color: meterColor,
//                       backgroundColor: Colors.grey[300],
//                       strokeWidth: 15,
//                     ),
//                   ),
//                   Text(
//                     '$value',
//                     style: GoogleFonts.amaranth(
//                       fontSize: screenHeight * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: meterColor,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           SizedBox(height: screenHeight * 0.03),
//         ],
//       ),
//     );
//   }

//   Color _getMeterColor(int calories) {
//     if (calories <= 1000) return Color.fromARGB(255, 15, 220, 22);
//     if (calories <= 2000) return Color(0xFFF9AB0B);
//     return Color.fromARGB(255, 222, 22, 8);
//   }

//   double _getMeterValue(int calories) {
//     return (calories <= 3000) ? calories / 3000 : 1.0;
//   }

//   Widget _buildActionButtons() {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildCustomButton(
//             'Analysis',
//             Color(0xFFF9AB0B),
//             Icons.analytics,
//             constraints.maxWidth * 0.4,
//             () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PredictionScreen()),
//               );
//             },
//           ),
//           _buildCustomButton(
//             'Camera',
//             Color(0xFFF9AB0B),
//             Icons.camera_alt,
//             constraints.maxWidth * 0.4,
//             () {
//               _showImageSourceOptions();
//             },
//           ),
//         ],
//       );
//     });
//   }

//   Widget _buildCustomButton(String label, Color color, IconData icon, double width, VoidCallback onPressed) {
//     return SizedBox(
//       width: width,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 15),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Flexible(
//               child: Text(
//                 label,
//                 style: GoogleFonts.amaranth(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpandableMealSection(String mealType, int suggestedCalories) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 mealExpansionStates[mealType] = !mealExpansionStates[mealType]!;
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF9AB0B).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     mealType,
//                     style: GoogleFonts.amaranth(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFF670977),
//                     ),
//                   ),
//                   Icon(
//                     mealExpansionStates[mealType]!
//                         ? Icons.arrow_drop_up
//                         : Icons.arrow_drop_down,
//                     color: const Color(0xFF670977),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             height: mealExpansionStates[mealType]! ? null : 0,
//             child: SingleChildScrollView(
//               physics: NeverScrollableScrollPhysics(),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$suggestedCalories Kcal suggested',
//                       style: GoogleFonts.amaranth(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       '${_calculateMealCalories(mealType)} Kcal',
//                       style: GoogleFonts.amaranth(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF670977),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildMealButton('Scan Meal', Icons.camera_alt, () {
//                           _showImageSourceOptions(mealType);
//                         }),
//                       ],
//                     ),
//                     ...detectedMeals[mealType]!.map((item) => Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4),
//                           child: Row(
//                             children: [
//                               Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
//                               SizedBox(width: 8),
//                               Text(item, style: GoogleFonts.amaranth(fontSize: 16)),
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   int _calculateMealCalories(String mealType) {
//     final mealItems = detectedMeals[mealType]!;
//     return mealItems.fold<int>(0, (sum, item) {
//       final kcalMatch = RegExp(r'(\d+(\.\d+)?) Kcal').firstMatch(item);
//       if (kcalMatch != null) {
//         return sum + double.parse(kcalMatch.group(1)!).round();
//       }
//       return sum;
//     });
//   }

//   Widget _buildMealButton(String label, IconData icon, VoidCallback onPressed) {
//     return Flexible(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF9AB0B),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Flexible(
//               child: Text(
//                 label,
//                 style: GoogleFonts.amaranth(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showImageSourceOptions([String? mealType]) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.camera_alt),
//             title: Text('Take a Photo'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUploadImage(ImageSource.camera, mealType);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.photo_library),
//             title: Text('Choose from Gallery'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUploadImage(ImageSource.gallery, mealType);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _pickAndUploadImage(ImageSource source, [String? mealType]) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile == null) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse("http://graduationproject-apis.runasp.net/api/FoodDetectionServiceV2/detect"),
//       );
//       request.files.add(await http.MultipartFile.fromPath('File', pickedFile.path));

//       var response = await request.send();

//       Navigator.of(context).pop();

//       if (response.statusCode == 200) {
//         final resString = await response.stream.bytesToString();
//         final jsonData = json.decode(resString);

//         if (mealType != null) {
//           List<String> newItems = [];
//           double mealCalories = 0;

//           for (var item in jsonData['items']) {
//             String formatted =
//                 "${item['type'].toString().capitalize()} - ${item['freshness']} - ${item['weight_grams']}g - ${item['calories']} Kcal";
//             newItems.add(formatted);
//             mealCalories += (item['calories'] as num).toDouble();
//           }

//           setState(() {
//             detectedMeals[mealType]!.addAll(newItems);
//             calorieCount += mealCalories.toInt();
//           });
//         } else {
//           List<String> displayItems = [];
//           List<String> dummyFreshness = [];

//           for (var item in jsonData['items']) {
//             displayItems.add(item['type']);
//             dummyFreshness.add(item['freshness']);
//           }

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => FoodScanScreen(
//       scannedItems: List<Map<String, dynamic>>.from(jsonData['items']),
//     ),
//   ),
// );

//         }
//       } else {
//         _showErrorDialog();
//       }
//     } catch (e) {
//       Navigator.of(context).pop();
//       _showErrorDialog();
//     }
//   }

//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Failed to upload or process the image.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
// }













import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'widgets/PredictionScreen.dart';
import 'widgets/FoodScanScreen.dart';

extension StringCasingExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int calorieCount = 0;

  Map<String, bool> mealExpansionStates = {
    'Breakfast': false,
    'Snacks': false,
    'Dinner': false,
    'Lunch': false,
  };

  Map<String, List<String>> detectedMeals = {
    'Breakfast': [],
    'Snacks': [],
    'Dinner': [],
    'Lunch': [],
  };

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم جدًا لتفعيل keepAlive

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF670977),
        title: Text(
          'My Progress',
          style: GoogleFonts.amaranth(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            _buildCalorieMeter(screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildActionButtons(),
            SizedBox(height: screenHeight * 0.02),
            _buildExpandableMealSection('Breakfast', 300),
            _buildExpandableMealSection('Snacks', 120),
            _buildExpandableMealSection('Dinner', 600),
            _buildExpandableMealSection('Lunch', 380),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieMeter(double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
      padding: EdgeInsets.all(screenHeight * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFF670977),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Calories Consumed',
            textAlign: TextAlign.center,
            style: GoogleFonts.amaranth(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: calorieCount),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              Color meterColor = _getMeterColor(value);
              double meterValue = _getMeterValue(value);
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: screenHeight * 0.2,
                    height: screenHeight * 0.2,
                    child: CircularProgressIndicator(
                      value: meterValue,
                      color: meterColor,
                      backgroundColor: Colors.grey[300],
                      strokeWidth: 15,
                    ),
                  ),
                  Text(
                    '$value',
                    style: GoogleFonts.amaranth(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.bold,
                      color: meterColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getMeterColor(int calories) {
    if (calories <= 1000) return Color.fromARGB(255, 15, 220, 22);
    if (calories <= 2000) return Color(0xFFF9AB0B);
    return Color.fromARGB(255, 222, 22, 8);
  }

  double _getMeterValue(int calories) {
    return (calories <= 3000) ? calories / 3000 : 1.0;
  }

  Widget _buildActionButtons() {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCustomButton(
            'Analysis',
            Color(0xFFF9AB0B),
            Icons.analytics,
            constraints.maxWidth * 0.4,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PredictionScreen()),
              );
            },
          ),
          _buildCustomButton(
            'Camera',
            Color(0xFFF9AB0B),
            Icons.camera_alt,
            constraints.maxWidth * 0.4,
            () {
              _showImageSourceOptions();
            },
          ),
        ],
      );
    });
  }

  Widget _buildCustomButton(String label, Color color, IconData icon, double width, VoidCallback onPressed) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.amaranth(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableMealSection(String mealType, int suggestedCalories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                mealExpansionStates[mealType] = !mealExpansionStates[mealType]!;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFFF9AB0B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mealType,
                    style: GoogleFonts.amaranth(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF670977),
                    ),
                  ),
                  Icon(
                    mealExpansionStates[mealType]!
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: const Color(0xFF670977),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: mealExpansionStates[mealType]! ? null : 0,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$suggestedCalories Kcal suggested',
                      style: GoogleFonts.amaranth(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${_calculateMealCalories(mealType)} Kcal',
                      style: GoogleFonts.amaranth(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF670977),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMealButton('Scan Meal', Icons.camera_alt, () {
                          _showImageSourceOptions(mealType);
                        }),
                      ],
                    ),
                    ...detectedMeals[mealType]!.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                          SizedBox(width: 8),
                          Text(item, style: GoogleFonts.amaranth(fontSize: 16)),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _calculateMealCalories(String mealType) {
    final mealItems = detectedMeals[mealType]!;
    return mealItems.fold<int>(0, (sum, item) {
      final kcalMatch = RegExp(r'(\d+(\.\d+)?) Kcal').firstMatch(item);
      if (kcalMatch != null) {
        return sum + double.parse(kcalMatch.group(1)!).round();
      }
      return sum;
    });
  }

  Widget _buildMealButton(String label, IconData icon, VoidCallback onPressed) {
    return Flexible(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF9AB0B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.amaranth(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceOptions([String? mealType]) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickAndUploadImage(ImageSource.camera, mealType);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickAndUploadImage(ImageSource.gallery, mealType);
            },
          ),
        ],
      ),
    );
  }

  void _pickAndUploadImage(ImageSource source, [String? mealType]) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://graduationproject-apis.runasp.net/api/FoodDetectionServiceV2/detect"),
      );
      request.files.add(await http.MultipartFile.fromPath('File', pickedFile.path));

      var response = await request.send();
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final resString = await response.stream.bytesToString();
        final jsonData = json.decode(resString);

        if (mealType != null) {
          List<String> newItems = [];
          double mealCalories = 0;

          for (var item in jsonData['items']) {
            String formatted =
                "${item['type'].toString().capitalize()} - ${item['freshness']} - ${item['weight_grams']}g - ${item['calories']} Kcal";
            newItems.add(formatted);
            mealCalories += (item['calories'] as num).toDouble();
          }

          setState(() {
            detectedMeals[mealType]!.addAll(newItems);
            calorieCount += mealCalories.toInt();
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodScanScreen(
                scannedItems: List<Map<String, dynamic>>.from(jsonData['items']),
              ),
            ),
          );
        }
      } else {
        _showErrorDialog();
      }
    } catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to upload or process the image.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
