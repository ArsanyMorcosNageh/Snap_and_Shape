// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:snap_and_shape/features/questionaire/presentation/view/questionaire_view.dart';
// import '../../../../core/widgets/auth_content.dart';
// import '../../../forgot_password/presentation/view/forgot_password_view.dart';
// import '../../../sign_up/presentation/view/sign_up_view.dart';

// class SignInView extends StatefulWidget {
//   @override
//   State<SignInView> createState() => _SignInViewState();
// }

// class _SignInViewState extends State<SignInView> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _loginUser() async {
//     setState(() => _isLoading = true);

//     final url = Uri.parse('http://graduationproject-apis.runasp.net/api/UsersIdentity/Login');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "email": _emailController.text.trim(),
//           "password": _passwordController.text,
//         }),
//       );

//       setState(() => _isLoading = false);

//       final responseData = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         final token = responseData['token'];
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('user_token', token);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => QuestionScreen()),
//         );
//       } else {
//         _showErrorDialog(responseData['message'] ?? 'Login failed.');
//       }
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showErrorDialog('Something went wrong. Please try again.');
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Login Failed'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AuthContent(
//         title: 'Sign In',
//         image: 'assets/images/Login.svg', // هيشتغل دلوقتي مع flutter_svg
//         fields: ['Email', 'Password'],
//         emailController: _emailController,
//         passwordController: _passwordController,
//         buttonText: _isLoading ? 'Loading...' : 'Next',
// onButtonPressed: _isLoading ? null : () => _loginUser(),
//         bottomText: "Don't have an account? ",
//         bottomButtonText: 'Sign Up',
//         onBottomButtonPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpView()));
//         },
//         extraButtonText: 'Forgot Password?',
//         onExtraButtonPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordView()));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:snap_and_shape/features/questionaire/presentation/view/questionaire_view.dart';
import '../../../../core/widgets/auth_content.dart';
import '../../../forgot_password/presentation/view/forgot_password_view.dart';
import '../../../sign_up/presentation/view/sign_up_view.dart';

class SignInView extends StatefulWidget {
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _loginUser() async {
    setState(() => _isLoading = true);

    final url = Uri.parse(
        'http://graduationproject-apis.runasp.net/api/UsersIdentity/Login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _emailController.text.trim(),
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
          MaterialPageRoute(builder: (_) => QuestionScreen()),
        );
      } else {
        String errorMessage = '';

        if (responseData is Map &&
            responseData['message'] != null &&
            responseData['message'].toString().trim().isNotEmpty &&
            responseData['message'].toString().toLowerCase() != 'bad request') {
          errorMessage = responseData['message'];
        } else {
          errorMessage = 'Please check your data and try again later';
        }

        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('A connection error occurred, please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthContent(
        title: 'Sign In',
        image: 'assets/images/Login.svg',
        fields: ['Email', 'Password'],
        emailController: _emailController,
        passwordController: _passwordController,
        buttonText: _isLoading ? 'Loading...' : 'Next',
        onButtonPressed: _isLoading ? null : () => _loginUser(),
        bottomText: "Don't have an account? ",
        bottomButtonText: 'Sign Up',
        onBottomButtonPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SignUpView()));
        },
        extraButtonText: 'Forgot Password?',
        onExtraButtonPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ForgotPasswordView()));
        },
      ),
    );
  }
}
