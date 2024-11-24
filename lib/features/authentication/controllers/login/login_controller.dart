import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/views/login/verify_pins.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class LoginController extends GetxController {
  //* variables
  //final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Logging in...',
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

      //* save data if remember me is selected
      // if (rememberMe.value) {
      //   localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      //   localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      // }
      // if (kDebugMode) {
      //   print(localStorage.read('REMEMBER_ME_EMAIL'));
      //   print(localStorage.read('REMEMBER_ME_PASSWORD'));
      // }

      //* verify user credentials
      final response = await AuthenticationRepository.instance
          .verifyCredentials(email.text.trim(), password.text.trim());
      final status = response.$1;
      //final json = jsonDecode(response.$2);
      final json = response.$2;

      if (status != 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(title: 'Oh snap!', message: 'Something went wrong');
        return;
      }

      Get.to(
        () => VerifyPinsScreen(
          userId: json['userId'],
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
