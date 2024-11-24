import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //? to make things scrollable on smaller devices
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* title
              Text(
                TTexts.signUpTitile,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(TSizes.spaceBtwSections),

              //* form
              const SignupForm(),
              const Gap(TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
