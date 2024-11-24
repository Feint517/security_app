import 'package:flutter/material.dart';
import 'package:security_app/features/authentication/views/login/widgets/verify_pins_form.dart';

import '../../../../common/styles/spacing_styles.dart';

class VerifyPinsScreen extends StatelessWidget {
  const VerifyPinsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [VerifyPinsForm(userId: userId)],
          ),
        ),
      ),
    );
  }
}
