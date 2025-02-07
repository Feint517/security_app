// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/server_repository.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/services/secure_storage.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';
import '../../views/signup/team_select.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //* variables
  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final activity = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //? form key for form validation

  Future<void> signup() async {
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

      //* check if server is running
      final isRunning = await ServerRepository.instance.isServerRunning();
      print('isRunning = $isRunning');
      if (!isRunning) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      final response =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        activity: activity.text.trim(),
        email: email.text.trim(),
        phoneNumber:
            THelperFunctions.formatPhoneNumber(phoneNumber.text.trim()),
        password: password.text.trim(),
      );

      await SecureStorage.saveTokensAndId(
        userId: response['userId'],
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
      );
      //* remove loader
      CustomFullscreenLoader.stopLoading();

      //* show success message
      CustomLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created.',
      );

      print('------------------Signup completed---------------------------');
      print('userId = ${await SecureStorage.getUserId()}');
      print('accessToken = ${await SecureStorage.getAccessToken()}');
      print('refreshToken = ${await SecureStorage.getRefreshToken()}');

      //* redirect

      // Get.to(
      //   () => PinsScreen(
      //     pin1: response['pin1'],
      //     pin2: response['pin2'],
      //   ),
      // );
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
