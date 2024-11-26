// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../utils/constants/api_constant.dart';
import '../services/secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository extends GetxController {
  Future<void> fetchData() async {
    final accessToken = await SecureStorage.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse(APIConstants.protectedEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        print('Data fetched successfully');
      } else if (response.statusCode == 401) {
        print('Access token expired');
        //await refreshToken(); ///* Call refresh token logic
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
