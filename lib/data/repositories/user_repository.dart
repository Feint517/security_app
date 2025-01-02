// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/data/user/user_model.dart';
import '../../utils/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  Future<UserModel> fetchUserData() async {
    final accessToken = await SecureStorage.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse(APIConstants.fetchUserData),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('jsonResponse = $jsonResponse');
        return UserModel.fromSnapshot(jsonResponse['user']);
      } else {
        throw Exception('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching user data');
    }
  }
}
