import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:security_app/features/authentication/controllers/login/verify_pins_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class VerifyPinsForm extends StatelessWidget {
  const VerifyPinsForm({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyPinsController());
    return Form(
      key: controller.verifyPinsFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            //* Pins
            TextFormField(
              controller: controller.pin1,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.pin1,
              ),
              keyboardType: TextInputType.number,
            ),
            const Gap(TSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.pin2,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.pin2,
              ),
              keyboardType: TextInputType.number,
            ),
            const Gap(TSizes.spaceBtwInputFields / 2),

            

            //* sign in button
            SizedBox(
              width: double.infinity, //? to make the sized button full width
              child: ElevatedButton(
                onPressed: () => controller.verifyPins(
                  userId,
                  controller.pin1.text,
                  controller.pin2.text,
                ),
                child: const Text(TTexts.signIn),
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
