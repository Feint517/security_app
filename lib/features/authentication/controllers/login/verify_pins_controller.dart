// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class VerifyPinsController extends GetxController {
  //* variables
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final rememberMe = false.obs;
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
      //final json = jsonDecode(response.$2);
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
      CustomLoaders.successSnackBar(title: 'Hooray');
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
