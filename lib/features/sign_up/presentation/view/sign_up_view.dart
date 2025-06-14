import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
      builder: (_) => AlertDialog(
        title: const Text('Sign Up Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
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
