// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/data/services/location_service.dart';
import 'package:security_app/features/authentication/views/login/verify_pins.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/server_repository.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  //* variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Please wait...',
        CustomAnimations.check,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      final errorMessage = await ServerRepository.instance.isServerRunning2();
      if (errorMessage != null) {
        CustomLoaders.errorSnackBar(
          title: 'Server Error',
          message: errorMessage, //? ✅ Display timeout or connection error
        );
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* check if location services are enabled
      try {
        await LocationService.instance.checkIsEnabled();
      } catch (e) {
        CustomLoaders.errorSnackBar(
          title: 'Enable location services!',
          message: 'Your location is required to login.',
        );
        CustomFullscreenLoader.stopLoading();
        return;
      }

      final position = await LocationService.instance.getCurrentLocation();

      //* verify user location
      final response1 = await AuthenticationRepository.instance.verifyLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      if (response1.$1 != 200) {
        final error = response1.$2['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }

      //* verify user credentials
      final response2 = await AuthenticationRepository.instance
          .verifyCredentials(email.text.trim(), password.text.trim());

      if (response2.$1 != 200) {
        final error = response2.$2['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }
      CustomLoaders.successSnackBar(
        title: 'Hooray',
        message: response2.$2['message'],
      );

      CustomFullscreenLoader.stopLoading();
      Get.to(
        () => VerifyPinsScreen(
          userId: response2.$2['userId'],
        ),
      );
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
