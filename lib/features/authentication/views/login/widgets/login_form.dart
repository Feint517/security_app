// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:security_app/data/repositories/project_repository.dart';
import 'package:security_app/data/repositories/server_repository.dart';
import 'package:security_app/data/repositories/team_repository.dart';
import 'package:security_app/testing_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../controllers/login/login_controller.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final testingController = Get.put(TestingController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            //?Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const Gap(TSizes.spaceBtwInputFields),

            //? password
            Obx(
              //? wrap it with observer to redraw the widget on change
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(TSizes.spaceBtwInputFields / 2),

            //* remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //* remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),
              ],
            ),
            const Gap(TSizes.spaceBtwSections),

            //* sign in button
            SizedBox(
              width: double.infinity, //? to make the sized button full width
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text('Next'),
              ),
            ),
            const Gap(TSizes.spaceBtwItems),

            //* create account button
            SizedBox(
              width: double.infinity, //? to make the sized button full width
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
            //* testing
            SizedBox(
              width: double.infinity, //? to make the sized button full width
              child: OutlinedButton(
                onPressed: () async {
                  await TeamRepository.instance.addTeamMember(
                    teamIds: [
                      '67767eda9abff481da286fe2',
                      '67767f119abff481da286fe4'
                    ],
                    userId: '677552226cb89f86550438fe',
                  );
                },
                child: const Text('Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
