import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/features/personalisation/controllers/user_controller.dart';
import 'package:security_app/navigation_menu.dart';

import '../../../common/styles/loaders.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/constants/animations.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/fullscreen_loader.dart';
import '../views/profile/profile.dart';

class UpdatePasswordController extends GetxController {
  static UpdatePasswordController get instance => Get.find();

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  Future<void> updateUserPassword() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'We are updating your information...',
        TAnimations.check,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // try {
      //   await UserRepository.instance.updateUserPassword(
      //     currentPassword: oldPassword.text,
      //     newPassword: newPassword.text,
      //   );
      // } catch (e) {
      //   CustomFullscreenLoader.stopLoading();
      //   CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      //   return;
      // }

      final response = await UserRepository.instance.updateUserPassword(
        currentPassword: oldPassword.text,
        newPassword: newPassword.text,
      );
      if (response.$1 != 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: response.$2['error']['message'],
        );
        return;
      }

      //* remove loader
      CustomFullscreenLoader.stopLoading();

      //* show success message
      CustomLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your password has been updated.',
      );

      //* move to previous screen
      Get.off(() => const NavigationMenu());
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
