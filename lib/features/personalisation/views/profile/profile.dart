import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:security_app/data/services/secure_storage.dart';
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
    final userController = UserController.instance;
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
                          showActionButton: false,
                        ),
                        const Gap(TSizes.spaceBtwItems),

                        SettingsMenuTile(
                          icon: Iconsax.personalcard,
                          title: "Name",
                          subtitle: 'subtitle',
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.safe_home,
                          title: "Phone Number",
                          subtitle: '+213 ......',
                          onTap: () {},
                        ),
                        SettingsMenuTile(
                          icon: Iconsax.wallet,
                          title: "Status",
                          subtitle: '+213 ......',
                          onTap: () {},
                        ),
                        //* app Setting
                        const Gap(TSizes.spaceBtwSections),
                        const CustomSectionHeading(
                          title: "App setting",
                          showActionButton: false,
                        ),

                        const Gap(TSizes.spaceBtwItems),

                        //* Logout button
                        const Gap(TSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              final refreshToken =
                                  await SecureStorage.getRefreshToken();
                              AuthenticationRepository.instance
                                  .logout(refreshToken!);
                            },
                            child: const Text('Log out'),
                          ),
                        ),
                        const Gap(TSizes.spaceBtwSections * 2.5),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //* body
          ],
        ),
      ),
    );
  }
}
