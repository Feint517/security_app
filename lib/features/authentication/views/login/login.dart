import 'package:flutter/material.dart';
import 'package:security_app/features/authentication/views/login/widgets/login_form.dart';
import '../../../../common/styles/spacing_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
