import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthContent extends StatefulWidget {
  final String title;
  final String image;
  final List<String> fields;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String bottomText;
  final String bottomButtonText;
  final VoidCallback onBottomButtonPressed;
  final String? extraButtonText;
  final VoidCallback? onExtraButtonPressed;
  final Widget? extraWidget;

  AuthContent({
    required this.title,
    required this.image,
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
  _AuthContentState createState() => _AuthContentState();
}

class _AuthContentState extends State<AuthContent> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF670977),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3, // زودنا الارتفاع هنا
                child: Center(
                  child: SvgPicture.asset(widget.image, height: 250),
                ),
              ),
              Expanded(
                flex: 5, // نقصنا المساحة البيضاء
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.amaranth(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...widget.fields.map((field) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  field,
                                  style: GoogleFonts.amaranth(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextField(
                                  obscureText: field.toLowerCase().contains('password') && !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your $field',
                                    hintStyle: GoogleFonts.amaranth(fontSize: 17, color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Color(0xFFF9AB0B), width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Color(0xFFF9AB0B), width: 2),
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
                                const SizedBox(height: 10),
                              ],
                            )),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF9AB0B),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: widget.onButtonPressed,
                            child: Text(
                              widget.buttonText,
                              style: GoogleFonts.amaranth(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (widget.extraButtonText != null && widget.onExtraButtonPressed != null)
                          Center(
                            child: TextButton(
                              onPressed: widget.onExtraButtonPressed,
                              child: Text(
                                widget.extraButtonText!,
                                style: GoogleFonts.amaranth(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.bottomText,
                                style: GoogleFonts.amaranth(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onBottomButtonPressed,
                                child: Text(
                                  widget.bottomButtonText,
                                  style: GoogleFonts.amaranth(
                                    color: Color(0xFFF9AB0B),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
