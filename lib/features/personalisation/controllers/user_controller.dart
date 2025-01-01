// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:security_app/data/repositories/user_repository.dart';
import '../../../data/user/user_model.dart';

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
      print(user.value.email);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
}
