// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/user_repository.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/services/secure_storage.dart';
import '../../../data/user/user_model.dart';
import '../../../utils/constants/sizes.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecords();
  }

  Future<void> fetchUserRecords() async {
    try {
      profileLoading.value = true;
      final response = await UserRepository.instance.fetchUserData();
      user(response);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  void deletaAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CustomSizes.md),
      title: 'Logout',
      middleText: 'Are you sure you want to logout of your account?',
      confirm: ElevatedButton(
        onPressed: () async {
          final refreshToken = await SecureStorage.getRefreshToken();
          AuthenticationRepository.instance.logout(refreshToken!);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: CustomSizes.lg),
          child: Text('Yes'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }
}
