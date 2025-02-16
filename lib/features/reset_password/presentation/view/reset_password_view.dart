
import 'package:flutter/material.dart';
import '../../../../core/widgets/verify_content.dart';
import '../../../sign_in/presentation/view/sign_in_view.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerifyContent(
      title: 'Reset Password',
          fields: ['Enter new password', 'Confirm password'],
      buttonText: 'Reset Password',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInView()),
        );
      },
      bottomText: 'Back to ',
      bottomButtonText: 'Sign In',
      onBottomButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
      },
    );
  }
}