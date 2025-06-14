import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

import '../../../../core/widgets/verify_content.dart';
import '../../../reset_password/presentation/view/reset_password_view.dart';

class VerifyOTP extends StatefulWidget {
  final String email; // ⬅️ استلام الإيميل من الشاشة السابقة

  const VerifyOTP({super.key, required this.email});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  String _enteredCode = "";
  bool _isLoading = false;

  Future<void> _verifyCode() async {
    if (_enteredCode.isEmpty || _enteredCode.length < 4) {
      _showDialog("Please enter the complete OTP.");
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      "http://graduationproject-apis.runasp.net/Email/Confirm-Reset Password?Code=$_enteredCode&Email=${widget.email}",
    );

    try {
      final response = await http.get(url);
      final jsonData = jsonDecode(response.body);

      if (jsonData['succeeded'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordView(email: widget.email)),
        );
      } else {
        _showDialog(jsonData['message'] ?? "Incorrect verification code.");
      }
    } catch (e) {
      _showDialog("Something went wrong. Please try again.");
    }

    setState(() => _isLoading = false);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Verification Failed"),
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
    return VerifyContent(
      title: 'Verification Code',
      fields: [],
      buttonText: _isLoading ? 'Loading...' : 'Verify',
      onButtonPressed: _verifyCode,
      bottomText: 'Didn’t receive the code? ',
      bottomButtonText: 'Resend code',
      onBottomButtonPressed: () {
        // إعادة إرسال الكود لو حبيت تضيفها لاحقًا
      },
      extraWidget: _buildVerificationCodeInput(context),
    );
  }

  Widget _buildVerificationCodeInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 50,
            fieldWidth: 40, // ✅ تقليل العرض لمنع overflow
            inactiveColor: Colors.grey,
            activeColor: Colors.orange,
            selectedColor: Colors.purple,
          ),
          mainAxisAlignment: MainAxisAlignment.center, // ✅ لضبط المحاذاة
          onChanged: (value) {
            _enteredCode = value;
          },
          onCompleted: (value) {
            _enteredCode = value;
          },
        ),
      ),
    );
  }
}
