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
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* heading
              Text(
                'Enter your old and new password to change it.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Gap(CustomSizes.spaceBtwSections),

              //* text field and button
              Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.oldPassword,
                      validator: (value) =>
                          CustomValidator.validateEmptyText('Password', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: CustomTexts.currentPassword,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),
                    const Gap(CustomSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.newPassword,
                      validator: (value) =>
                          CustomValidator.validateEmptyText('Password', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: CustomTexts.newPassword,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(CustomSizes.spaceBtwSections),

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
