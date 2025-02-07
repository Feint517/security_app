import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validators.dart';
import '../../controllers/update_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePasswordController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Change password',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* heading
              Text(
                'Enter your old and new password to change it.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Gap(TSizes.spaceBtwSections),

              //* text field and button
              Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.oldPassword,
                      validator: (value) =>
                          TValidator.validateEmptyText('Password', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.currentPassword,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),
                    const Gap(TSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.newPassword,
                      validator: (value) =>
                          TValidator.validateEmptyText('Password', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.newPassword,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(TSizes.spaceBtwSections),

              //* save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateUserPassword(),
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
