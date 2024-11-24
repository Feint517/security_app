import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class CustomFullscreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const Gap(250), //? adjust as needed
              CustomAnimationLoader(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); //? close the dialog using the navigator
  }
}
