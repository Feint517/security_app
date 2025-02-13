import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:security_app/data/repositories/server_repository.dart';
import 'package:security_app/data/repositories/user_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/features/personalisation/views/profile/change_password.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custon_shapes/container/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/misc/custom_section_heading.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* header
            CustomPrimaryHeaderContainer(
              height: THelperFunctions.screenHeight(),
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),

                  //* user profile card
                  UserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //* account settings
                        const CustomSectionHeading(
                          title: "Account details",
                          textColor: Colors.white,
                          showActionButton: false,
                        ),
                        const Gap(TSizes.spaceBtwItems),

                        SettingsMenuTile(
                          icon: Iconsax.personalcard,
                          title: "Name",
                          subtitle: controller.user.value.fullName,
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.personalcard,
                          title: "Username",
                          subtitle: controller.user.value.username,
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.people,
                          title: "Email",
                          subtitle: controller.user.value.email,
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.call,
                          title: "Phone Number",
                          subtitle: controller.user.value.phoneNumber,
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.security_card,
                          title: "Password",
                          subtitle: 'Click to change',
                          onTap: () =>
                              Get.to(() => const ChangePasswordScreen()),
                        ),
                        //* app Setting
                        const Gap(TSizes.spaceBtwSections),
                        const CustomSectionHeading(
                          title: "App setting",
                          textColor: Colors.white,
                          showActionButton: false,
                        ),

                        const Gap(TSizes.spaceBtwItems),

                        //* Logout button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Confirm Logout"),
                                  content: const Text(
                                    "Are you sure you want to logout?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                final refreshToken =
                                    await SecureStorage.getRefreshToken();
                                AuthenticationRepository.instance
                                    .logout(refreshToken!);
                              }
                            },
                            child: const Text(
                              'Log out',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Gap(TSizes.spaceBtwSections),

                        // SizedBox(
                        //   width: double.infinity,
                        //   child: OutlinedButton(
                        //     onPressed: () async {
                        //       UserRepository.instance.fetchUserData();
                        //     },
                        //     child: const Text(
                        //       'Test',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        // const Gap(TSizes.spaceBtwItems),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
