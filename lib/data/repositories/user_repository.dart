// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/data/user/user_model.dart';
import '../../utils/constants/api_constant.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  Future<UserModel> fetchUserData() async {
    try {
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.fetchUserData,
        method: 'get',
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('----------------------User Data Fetched Successfuly');
        print('user info => ${jsonResponse['user']}');
        return UserModel.fromSnapshot(jsonResponse['user']);
      } else {
        throw Exception('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching user data');
    }
  }

  Future<(int status, dynamic response)> updateUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final body = {
        "currentPassword": currentPassword,
        "newPassword": newPassword
      };
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.updatePassword,
        method: 'put',
        body: body,
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(
            '----------------------Password changed Successfully----------------------');
        return (response.statusCode, json as dynamic);
      } else {
        //throw Exception('Failed to update user password: ${response.body}');
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while updating user password: $e');
    }
  }
}
