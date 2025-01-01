// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:security_app/utils/constants/api_constant.dart';

class ServerRepository extends GetxController {
  static ServerRepository get instance => Get.find();
  @override
  void onReady() {
    isServerRunning();
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
}
