import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../personalisation/controllers/user_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.white),
          ),
          Obx(
            //? the reason to wrap it with Obx is that the user details don't arrive immediately,
            //? but arrives after some milliseconds, so we need to refresh the widget as soon as
            //? the user information arrive
            () {
              if (controller.profileLoading.value) {
                //* display a shimmer loader while user profile is being loaded
                return const CustomShimmerEffect(width: 80, height: 15);
              }
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.white),
              );
            },
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () => Get.to(() => const SettingsScreen()),
      //     icon: const Icon(Icons.settings),
      //   )
      // ],
    );
  }
}
