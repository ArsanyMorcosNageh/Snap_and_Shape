import 'package:flutter/material.dart';

import '../../../../core/widgets/auth_content.dart';
import '../../../sign_in/presentation/view/sign_in_view.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthContent(
      title: 'Sign Up',
      image: 'assets/images/Sign_up.svg',    
        fields: ['User Name', 'Email', 'Password'],
      buttonText: 'Next',
      onButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
      },
      bottomText: 'Already have an account? ',
      bottomButtonText: 'Sign In',
      onBottomButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
      },
    );
  }
}