import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/verify_content.dart';
import '../../../reset_password/presentation/view/reset_password_view.dart';

class VerifyOTP extends StatefulWidget {
  final String email;

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
                'Verification Failed',
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
    return VerifyContent(
      title: 'Verification Code',
      fields: [],
      buttonText: _isLoading ? 'Loading...' : 'Verify',
      onButtonPressed: _verifyCode,
      bottomText: 'Didn’t receive the code? ',
      bottomButtonText: 'Resend code',
      onBottomButtonPressed: () {
        // ممكن تضيف دالة إعادة الإرسال هنا
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
            fieldWidth: 38,
            activeColor: Colors.orange,
            inactiveColor: Colors.grey,
            selectedColor: Colors.purple,
            activeFillColor: Colors.white,
          ),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // مسافات خفيفة
          onChanged: (value) => _enteredCode = value,
          onCompleted: (value) => _enteredCode = value,
        ),
      ),
    );
  }
}
