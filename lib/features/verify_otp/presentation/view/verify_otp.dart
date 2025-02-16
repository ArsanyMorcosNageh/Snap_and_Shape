import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // مكتبة لإدخال رمز التحقق
import '../../../../core/widgets/verify_content.dart';
import '../../../reset_password/presentation/view/reset_password_view.dart';

class VerifyOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerifyContent(
      title: 'Verification Code',
      fields: [], // سيتم استبدالها بمربعات إدخال الرمز
      buttonText: 'Verify',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordView()),
        );
      },
      bottomText: 'Didn’t receive the code? ',
      bottomButtonText: 'Resend code',
      onBottomButtonPressed: () {
        // منطق إعادة الإرسال
      },
      extraWidget: _buildVerificationCodeInput(context),
    );
  }

  Widget _buildVerificationCodeInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 50,
          fieldWidth: 50,
          inactiveColor: Colors.grey,
          activeColor: Colors.orange,
          selectedColor: Colors.purple,
        ),
        onChanged: (value) {
          print(value); // يمكن استخدام هذا النص للتحقق من الإدخال
        },
        onCompleted: (value) {
          print("Completed: $value");
        },
      ),
    );
  }
}
