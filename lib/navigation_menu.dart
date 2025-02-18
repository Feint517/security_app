import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/features/personalisation/views/profile/profile.dart';

import 'features/posting/views/home.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: dark ? CustomColors.black : CustomColors.white,
        backgroundColor: CustomColors.primary,
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          controller.selectedIndex.value = index;
        },
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
}
