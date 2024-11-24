import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/data/services/location_service.dart';
import 'package:security_app/features/authentication/views/login/verify_pins.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
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
        TAnimations.check,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      final position = await LocationService.instance.getCurrentLocation();

      //* verify user credentials
      final response1 = await AuthenticationRepository.instance
          .verifyCredentials(email.text.trim(), password.text.trim());
      final status1 = response1.$1;
      final json1 = response1.$2;

      //* verify user location
      final response2 = await AuthenticationRepository.instance.verifyLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
      final status2 = response2.$1;
      final json2 = response2.$2;

      if (status1 != 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: json1['message'],
        );
        return;
      }
      if (status2 != 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: json2['message'],
        );
        return;
      }

      Get.to(
        () => VerifyPinsScreen(
          userId: json1['userId'],
        ),
      );

      //* redirect
      //AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
