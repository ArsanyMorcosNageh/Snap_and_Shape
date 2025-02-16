import 'package:flutter/material.dart';
import 'package:snap_and_shape/features/questionaire/presentation/view/questionaire_view.dart';
import '../../../../core/widgets/auth_content.dart';
import '../../../forgot_password/presentation/view/forgot_password_view.dart';
import '../../../sign_up/presentation/view/sign_up_view.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthContent(
      title: 'Sign In',
      image: 'assets/images/Login.svg',      fields: ['Email', 'Password'],
      buttonText: 'Next',
      onButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen()));
      },
      bottomText: "Don't have an account? ",
      bottomButtonText: 'Sign Up',
      onBottomButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()));
      },
      extraButtonText: 'Forgot Password?',
      onExtraButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordView()));
      },
    );
  }
}
