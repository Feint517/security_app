// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:security_app/utils/constants/api_constant.dart';

import '../services/secure_storage.dart';

class ServerRepository extends GetxController {
  static ServerRepository get instance => Get.find();
  @override
  void onReady() async {
    isServerRunning();
    final userId = await SecureStorage.getUserId();
    final accessToken = await SecureStorage.getAccessToken();
    final refreshToken = await SecureStorage.getRefreshToken();
    print('userId = $userId');
    print('accessToken = $accessToken');
    print('refreshToken = $refreshToken');
  }

  Future<bool> isServerRunning() async {
    try {
      final response = await http.get(Uri.parse(APIConstants.ping)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Connection timed out');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Server Response: ${jsonResponse['message']}');
        return true; //? Server is running
      } else {
        print('Unexpected Response: ${response.statusCode}');
        return false; //? Server responded, but not with 200
      }
    } catch (e) {
      print('Error: $e');
      return false; //? Unable to connect
    }
  }

  Future<String?> isServerRunning2() async {
    try {
      final response = await http.get(Uri.parse(APIConstants.ping)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Server did not respond in time.');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Server Response: ${jsonResponse['message']}');
        return null; //? ✅ No error, server is running
      } else {
        return 'Unexpected response: ${response.statusCode}'; //? ❌ API error
      }
    } on TimeoutException {
      return 'Connection timeout: Server is not responding.';
    } on http.ClientException {
      return 'Network error: Unable to reach the server.';
    } catch (e) {
      print('Error: $e');
      return 'An unexpected error occurred.';
    }
  }
}
