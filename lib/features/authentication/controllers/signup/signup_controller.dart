// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/views/signup/pins.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //* variables
  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //? form key for form validation

  void signup() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'We are processing your information...',
        TAnimations.check,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      final response =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        firstName.text.trim(),
        lastName.text.trim(),
        userName.text.trim(),
        email.text.trim(),
        phoneNumber.text.trim(),
        password.text.trim(),
      );
      //* remove loader
      CustomFullscreenLoader.stopLoading();

      //* show success message
      CustomLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created.',
      );

      //* redirect
      Get.to(
        () => PinsScreen(
          pin1: response['pin1'],
          pin2: response['pin2'],
        ),
      );
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  // void signupTest() async {
  //   try {
  //     final response =
  //         await AuthenticationRepository.instance.registerWithEmailAndPassword(
  //       firstName.text.trim(),
  //       lastName.text.trim(),
  //       userName.text.trim(),
  //       email.text.trim(),
  //       password.text.trim(),
  //     );
  //     print('type = ${response.runtimeType}');
  //     print(response);
  //     print('pin1 = ${response['pin1']}');
  //     print('pin2 = ${response['pin2']}');

  //     //* show success message
  //     CustomLoaders.successSnackBar(
  //       title: 'Congratulations!',
  //       message: 'Your account has been created.',
  //     );
  //   } catch (e) {
  //     //* show some generic error to the user
  //     CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
  //   }
  // }
}
