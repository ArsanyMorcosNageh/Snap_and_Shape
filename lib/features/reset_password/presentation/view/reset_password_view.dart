import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../../core/widgets/verify_content.dart';
import '../../../sign_in/presentation/view/sign_in_view.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;
  const ResetPasswordView({super.key, required this.email});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final email = widget.email;

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showAlert("Please enter both password fields.");
      return;
    }

    if (password != confirmPassword) {
      _showAlert("Passwords do not match.");
      return;
    }

    try {
      final uri = Uri.parse("http://graduationproject-apis.runasp.net/Email/Change-Password");

      final request = http.MultipartRequest("POST", uri)
        ..fields['Email'] = email
        ..fields['NewPassword'] = password
        ..fields['ConfirmNewPassword'] = confirmPassword;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (data['succeeded'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignInView()),
        );
      } else {
        _showAlert(data['message'] ?? "Something went wrong.");
      }
    } catch (e) {
      _showAlert("Something went wrong. Please try again.");
    }
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
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
    return VerifyContent(
      title: 'Reset Password',
      fields: [],
      buttonText: 'Reset Password',
      onButtonPressed: _resetPassword,
      bottomText: 'Back to ',
      bottomButtonText: 'Sign In',
      onBottomButtonPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignInView()),
        );
      },
      extraWidget: Column(
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter new password',
              hintStyle: GoogleFonts.amaranth(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Confirm password',
              hintStyle: GoogleFonts.amaranth(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
