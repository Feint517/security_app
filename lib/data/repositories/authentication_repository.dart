// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/features/authentication/views/signup/team_select.dart';
import 'package:security_app/navigation_menu.dart';
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
    //Get.to(()=> const TeamSelectScreen());
    final loggedInState = await isLoggedIn();
    if (loggedInState) {
      Get.offAll(() => const NavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<dynamic> registerWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String username,
    required String activity,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "activity": activity,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse(APIConstants.registration),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", //? Set the content type to JSON
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timed out. Please try again.');
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
        print('json = $json');
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
        Get.offAll(() => const LoginScreen());
        SecureStorage.clearTokens();
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
        print('accessToken = ${json['accessToken']}');
        print('refreshToken = ${json['refreshToken']}');
        //final newAccessToken = json['accessToken'];
        //final newRefreshToken = json['refreshToken'];

        //print('newAccessToken = $newAccessToken');
        //print('newRefreshToken = $newRefreshToken');

        //* Save new tokens
        //await SecureStorage.saveTokens(newAccessToken, newRefreshToken);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error refreshing token: $e');
      //* Optionally log out the user if refresh fails
      //await SecureStorage.clearTokens();
      //Get.offAll(() => const LoginScreen());
    }
  }
}
