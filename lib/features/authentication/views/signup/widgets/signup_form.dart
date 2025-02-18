import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../controllers/signup/signup_controller.dart';
class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      CustomValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CustomTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const Gap(CustomSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      CustomValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CustomTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const Gap(CustomSizes.spaceBtwInputFields),

          //* username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                CustomValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CustomTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const Gap(CustomSizes.spaceBtwInputFields),

          //* activity
          TextFormField(
            controller: controller.activity,
            validator: (value) =>
                CustomValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CustomTexts.activity,
              prefixIcon: Icon(Iconsax.hashtag_down),
            ),
          ),
          const Gap(CustomSizes.spaceBtwInputFields),

          //* email
          TextFormField(
            controller: controller.email,
            validator: (value) => CustomValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: CustomTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const Gap(CustomSizes.spaceBtwInputFields),

          //* phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CustomValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: CustomTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const Gap(CustomSizes.spaceBtwInputFields),

          //* password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => CustomValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: CustomTexts.password,
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
          const Gap(CustomSizes.spaceBtwInputFields),

          //* sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await controller.signup();
                
              },
              child: const Text(CustomTexts.createAccount),
            ),
          ),
          const Gap(CustomSizes.spaceBtwInputFields),
        ],
      ),
    );
  }
}
