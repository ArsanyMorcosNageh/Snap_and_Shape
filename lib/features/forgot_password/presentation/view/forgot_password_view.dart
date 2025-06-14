import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        _showAlert(message); // ❗عرض الرسالة من الـ backend
      }
    } catch (e) {
      _showAlert("Something went wrong. Please try again.");
    }

    setState(() => _isLoading = false);
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset Password Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
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
