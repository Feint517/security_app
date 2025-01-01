// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/data/user/user_model.dart';
import '../../utils/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Future<void> fetchUserData() async {
  //   final accessToken = await SecureStorage.getAccessToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIConstants.protectedEndpoint),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $accessToken",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       print('Data fetched successfully');
  //     } else if (response.statusCode == 401) {
  //       print('Access token expired');
  //       //await refreshToken(); //* Call refresh token logic
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  Future<UserModel> fetchUserData() async {
    final url = Uri.parse(APIConstants.fetchUserData);
    final accessToken = await SecureStorage.getAccessToken();

    try {
      final response = await http.get(
        url,
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
