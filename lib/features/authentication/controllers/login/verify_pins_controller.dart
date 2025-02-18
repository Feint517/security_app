// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/services/secure_storage.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class VerifyPinsController extends GetxController {
  //* variables
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  GlobalKey<FormState> verifyPinsFormKey = GlobalKey<FormState>();

  Future<void> verifyPins(String userId, String pin1, String pin2) async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Logging in...',
        CustomAnimations.check,
      );

      //* verify pins
      final response = await AuthenticationRepository.instance
          .verifyPins(userId, pin1, pin2);
      final status = response.$1;
      final json = response.$2;
      print(json);

      if (status != 200) {
        final error = json['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }

      await SecureStorage.saveTokensAndId(
          userId: json['userId'],
          accessToken: json['accessToken'],
          refreshToken: json['refreshToken'],
        );
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
