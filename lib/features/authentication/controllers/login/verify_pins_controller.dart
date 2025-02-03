// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/controllers/login/login_controller.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/services/secure_storage.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class VerifyPinsController extends GetxController {
  //* variables
  //final localStorage = GetStorage();
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  GlobalKey<FormState> verifyPinsFormKey = GlobalKey<FormState>();

  Future<void> verifyPins(String userId, String pin1, String pin2) async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Logging in...',
        TAnimations.check,
      );

      //* form validation
      // if (!verifyPinsFormKey.currentState!.validate()) {
      //   CustomFullscreenLoader.stopLoading();
      //   return;
      // }

      //* verify pins
      final response = await AuthenticationRepository.instance
          .verifyPins(userId, pin1, pin2);
      final status = response.$1;
      final json = response.$2;
      print(json);

      if (status != 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: 'Something went wrong',
        );
        return;
      }
      //* save tokens to local storage
      // if (LoginController.instance.rememberMe.value) {
      //   await SecureStorage.saveTokens(
      //     accessToken: json['accessToken'],
      //     refreshToken: json['refreshToken'],
      //   );
      // }
      if (LoginController.instance.rememberMe.value) {
        await SecureStorage.saveTokensAndId(
          userId: json['userId'],
          accessToken: json['accessToken'],
          refreshToken: json['refreshToken'],
        );
      }
      CustomLoaders.successSnackBar(title: 'Hooray', message: 'Welcome Back');
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
