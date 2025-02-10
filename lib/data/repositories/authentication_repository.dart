// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    final loggedInState = await isLoggedIn();
    if (loggedInState) {
      Get.offAll(() => const NavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<(int status, dynamic response)> registerWithEmailAndPassword({
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
      final json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        //*Handle success
        print('json response => ${jsonDecode(response.body)}');
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

  Future<String?> refreshTokens() async {
    final refreshToken = await SecureStorage.getRefreshToken();

    try {
      final response = await http.post(
        Uri.parse(APIConstants.refreshTokens),
        body: jsonEncode({"refreshToken": refreshToken}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('---------------REFRESHING TOKENS------------------------');
        print('new accessToken = ${json['accessToken']}');
        print('new refreshToken = ${json['refreshToken']}');
        final newAccessToken = json['accessToken'];
        final newRefreshToken = json['refreshToken'];

        //* Save new tokens
        await SecureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        return newAccessToken;
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
      //* Optionally log out the user if refresh fails
      //await SecureStorage.clearTokens();
      //Get.offAll(() => const LoginScreen());
    }
  }

  //* Function to make API requests with automatic token refresh
  Future<http.Response> authenticatedRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    String? accessToken = await SecureStorage.getAccessToken();

    //* Define headers
    final headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    //* Create request based on method type
    http.Response response;
    final url = Uri.parse(endpoint);
    print('Request sent to => $url');

    try {
      switch (method.toUpperCase()) {
        case "GET":
          response = await http.get(url, headers: headers);
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "POST":
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "PUT":
          response =
              await http.put(url, headers: headers, body: jsonEncode(body));
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "DELETE":
          response = await http.delete(url, headers: headers);
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        default:
          throw Exception("Unsupported HTTP method: $method");
      }
    } catch (e) {
      print("Error making $method request: $e");
      return http.Response("Error: $e", 500);
    }

    //* If access token is expired, refresh it
    if (response.statusCode == 401) {
      print("Access token expired. Attempting to refresh...");

      accessToken = await refreshTokens();
      if (accessToken == null) {
        print("User needs to log in again.");
        return response; //? Return original response if refre`sh fails
      }

      //* Retry the request with the new access token
      headers["Authorization"] = "Bearer $accessToken";

      switch (method.toUpperCase()) {
        case "GET":
          response = await http.get(url, headers: headers);
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "POST":
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "PUT":
          response =
              await http.put(url, headers: headers, body: jsonEncode(body));
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
        case "DELETE":
          response = await http.delete(url, headers: headers);
          print(
              '-------------------------AUTHENTICATED RESPONSE INFO------------------------------');
          print('status code = ${response.statusCode}');
          print('body = ${response.body}');
          break;
      }
    }
    return response;
  }
}
