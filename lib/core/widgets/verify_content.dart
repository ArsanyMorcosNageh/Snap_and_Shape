import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyContent extends StatefulWidget {
  final String title;
  final List<String> fields;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String bottomText;
  final String bottomButtonText;
  final VoidCallback onBottomButtonPressed;
  final String? extraButtonText;
  final VoidCallback? onExtraButtonPressed;
  final Widget? extraWidget;

  VerifyContent({
    required this.title,
    required this.fields,
    required this.buttonText,
    required this.onButtonPressed,
    required this.bottomText,
    required this.bottomButtonText,
    required this.onBottomButtonPressed,
    this.extraButtonText,
    this.onExtraButtonPressed,
    this.extraWidget,
  });

  @override
  _VerifyContentState createState() => _VerifyContentState();
}

class _VerifyContentState extends State<VerifyContent> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF670977),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amaranth(
                    color: Colors.white,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ...widget.fields.map(
                  (field) => Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                    child: TextField(
                      obscureText: field.toLowerCase().contains('password') && !_isPasswordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: field,
                        hintStyle: GoogleFonts.amaranth(fontSize: screenWidth * 0.045),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: field.toLowerCase().contains('password')
                            ? IconButton(
                                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                if (widget.extraWidget != null) ...[
                  SizedBox(height: screenHeight * 0.02),
                  widget.extraWidget!,
                ],
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF9AB0B),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: widget.onButtonPressed,
                  child: Text(
                    widget.buttonText,
                    style: GoogleFonts.amaranth(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.extraButtonText != null && widget.onExtraButtonPressed != null) ...[
                  SizedBox(height: screenHeight * 0.015),
                  TextButton(
                    onPressed: widget.onExtraButtonPressed,
                    child: Text(
                      widget.extraButtonText!,
                      style: GoogleFonts.amaranth(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.bottomText,
                      style: GoogleFonts.amaranth(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onBottomButtonPressed,
                      child: Text(
                        widget.bottomButtonText,
                        style: GoogleFonts.amaranth(
                          color: Color(0xFFF9AB0B),
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
