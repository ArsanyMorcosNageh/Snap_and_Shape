import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/auth_content.dart';
import '../../../sign_in/presentation/view/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    setState(() => _isLoading = true);

    final url = Uri.parse(
        'http://graduationproject-apis.runasp.net/api/UsersIdentity/Register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _emailController.text.trim(),
          "displayName": _usernameController.text.trim(),
          "password": _passwordController.text,
        }),
      );

      setState(() => _isLoading = false);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['token'] != null) {
        final token = responseData['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInView()),
        );
      } else {
        String errorMessage = '';

        if (responseData is Map &&
            (responseData.containsKey('errors') ||
                responseData.containsKey('erorrs'))) {
          final errorsList = responseData['errors'] ?? responseData['erorrs'];
          if (errorsList is List && errorsList.isNotEmpty) {
            errorMessage = errorsList.map((e) => e.toString()).join('\n');
          }
        } else if (responseData['message'] != null &&
            responseData['message'].toString().trim().isNotEmpty &&
            responseData['message'].toString().toLowerCase() != 'bad request') {
          errorMessage = responseData['message'].toString();
        } else {
          errorMessage = 'حدث خطأ أثناء إنشاء الحساب، حاول مرة تانية.';
        }

        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('حصل خطأ في الاتصال. حاول مرة تانية.');
    }
  }

  void _showErrorDialog(String message) {
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
                'Sign Up Failed',
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
    return Scaffold(
      body: AuthContent(
        title: 'Sign Up',
        image: 'assets/images/Sign_up.svg',
        fields: ['User Name', 'Email', 'Password'],
        usernameController: _usernameController,
        emailController: _emailController,
        passwordController: _passwordController,
        buttonText: _isLoading ? 'Loading...' : 'Next',
        onButtonPressed: _isLoading ? null : _registerUser,
        bottomText: 'Already have an account? ',
        bottomButtonText: 'Sign In',
        onBottomButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInView()),
          );
        },
      ),
    );
  }
}
