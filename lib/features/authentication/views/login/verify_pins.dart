import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/views/login/login.dart';
import 'package:security_app/features/authentication/views/login/widgets/verify_pins_form.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyPinsScreen extends StatelessWidget {
  const VerifyPinsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () => Get.offAll(() => const LoginScreen()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //* title
              Text(
                TTexts.enterPins,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(TSizes.spaceBtwSections),

              //* form
              VerifyPinsForm(userId: userId),
              const Gap(TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
