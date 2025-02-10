// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/server_repository.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../../common/styles/loaders.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/services/location_service.dart';
import '../../../../data/services/secure_storage.dart';
import '../../../../utils/constants/animations.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';
import '../../views/signup/team_select.dart';
import 'team_select_controller.dart';

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

  final teamsController = Get.put(TeamSelectController());

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
      final status1 = response1.$1;
      final json1 = response1.$2;

      if (status1 != 200) {
        final error = json1['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }

      final response =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        firstName:
            THelperFunctions.capitalizeFirstLetter(firstName.text.trim()),
        lastName: THelperFunctions.capitalizeFirstLetter(lastName.text.trim()),
        username: THelperFunctions.capitalizeFirstLetter(userName.text.trim()),
        activity: THelperFunctions.capitalizeFirstLetter(activity.text.trim()),
        email: email.text.trim().toLowerCase(),
        phoneNumber:
            THelperFunctions.formatPhoneNumber(phoneNumber.text.trim()),
        password: password.text.trim(),
      );

      if (response.$1 != 201) {
        final error = response.$2['error'];
        print('error => $error');
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }

      await SecureStorage.saveTokensAndId(
        userId: response.$2['userId'],
        accessToken: response.$2['accessToken'],
        refreshToken: response.$2['refreshToken'],
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
      await teamsController.searchForTeams();
      Get.to(() => const TeamSelectScreen());
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
