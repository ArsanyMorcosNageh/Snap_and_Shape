import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:snap_and_shape/features/verify_otp/presentation/view/verify_otp.dart';
import '../../../../core/widgets/auth_content.dart';
import '../../../sign_in/presentation/view/sign_in_view.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showAlert("Please enter your email");
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
        'http://graduationproject-apis.runasp.net/Email/Send-OTP to Reset-Password?Email=$email');

    try {
      final response = await http.post(url);
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'] ?? 'Unexpected error';

      if (jsonResponse['succeeded'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyOTP(email: email)),
        );
      } else {
        _showAlert(message);
      }
    } catch (e) {
      _showAlert("Something went wrong. Please try again.");
    }

    setState(() => _isLoading = false);
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Color(0xFF670977), size: 40),
              const SizedBox(height: 15),
              Text(
                'Reset Password Failed',
                style: GoogleFonts.amaranth(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF670977),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9AB0B),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'OK',
                  style: GoogleFonts.amaranth(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthContent(
      title: 'Forgot Password',
      image: 'assets/images/forgot_password.svg',
      fields: ['Enter your email address'],
      emailController: _emailController,
      buttonText: _isLoading ? 'Loading...' : 'Submit',
      onButtonPressed: _isLoading ? null : _submitEmail,
      bottomText: 'Get back to ',
      bottomButtonText: 'Sign In',
      onBottomButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInView()),
        );
      },
    );
  }
}
