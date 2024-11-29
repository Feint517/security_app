// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/features/posting/views/home.dart';
import 'package:security_app/utils/constants/api_constant.dart';
import '../../features/authentication/views/login/login.dart';
import 'package:http/http.dart' as http;

import '../services/secure_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();

  //? called from main.dart in app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove(); //? remove the native splash screen
    screenRedirect(); //? redirect to the appropriate screen
  }

  void screenRedirect() async {
    final loggedInState = await isLoggedIn();
    if (loggedInState) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<dynamic> registerWithEmailAndPassword(
    String firstName,
    String lastName,
    String username,
    String email,
    String password,
  ) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "email": email,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse(APIConstants.registration),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      if (response.statusCode == 201) {
        //*Handle success
        final json = jsonDecode(response.body);
        print(json);
        return json;
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<(int status, dynamic response)> verifyCredentials(
    String email,
    String password,
  ) async {
    final body = {"email": email, "password": password};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.verifyCredentials),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(json);
        return (response.statusCode, json as dynamic);
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<(int status, dynamic response)> verifyPins(
    String userId,
    String pin1,
    String pin2,
  ) async {
    final body = {"userId": userId, "pin1": pin1, "pin2": pin2};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.verifyPins),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(json);
        return (response.statusCode, json as dynamic);
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<(int status, dynamic response)> verifyLocation({
    String? latitude,
    String? longitude,
  }) async {
    final body = {"latitude": latitude, "longitude": longitude};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.verifyLocation),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(json);
        return (response.statusCode, json as dynamic);
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<(int status, dynamic response)> logout(String refreshToken) async {
    final body = {"refreshToken": refreshToken};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.logout),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(json);
        return (response.statusCode, json as dynamic);
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<bool> verifyRefreshToken(String refreshToken) async {
    final body = {"refreshToken": refreshToken};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.verifyRefreshToken),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(json);
        return true;
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  //* check if the user is currently logged in
  Future<bool> isLoggedIn() async {
    final accessToken = await SecureStorage.getAccessToken();
    return accessToken != null;
  }

  Future<void> refreshTokens() async {
    final refreshToken = await SecureStorage.getRefreshToken();

    try {
      final response = await http.post(
        Uri.parse(APIConstants.refreshTokens),
        body: jsonEncode({"refreshToken": refreshToken}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final newAccessToken = json['accessToken'];
        final newRefreshToken = json['refreshToken'];

        //* Save new tokens
        await SecureStorage.saveTokens(newAccessToken, newRefreshToken);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error refreshing token: $e');
      //* Optionally log out the user if refresh fails
      await SecureStorage.clearTokens();
      Get.offAll(() => const LoginScreen());
    }
  }
}
