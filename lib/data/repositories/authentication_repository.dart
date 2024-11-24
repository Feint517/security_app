// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/utils/constants/api_constant.dart';
import '../../features/authentication/views/login/login.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();

  //? called from main.dart in app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove(); //? remove the native splash screen
    //screenRedirect(); //? redirect to the appropriate screen
  }

  void screenRedirect() async {
    deviceStorage.writeIfNull('isUserExist', false);
    if (deviceStorage.read('isUserExist') != true) {
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

  // Future<void> loginWithEmailAndPassword(
  //   String email,
  //   String password,
  // ) async {
  //   final body = {"email": email, "password": password};
  //   try {
  //     final response = await http.post(
  //       Uri.parse(APIConstants.login),
  //       body: jsonEncode(body),
  //       headers: {
  //         "Content-Type": "application/json", //? Set the content type to JSON
  //       },
  //     );
  //     if (response.statusCode == 201) {
  //       final json = jsonDecode(response.body);
  //       print(json);
  //       ///*Handle success
  //     } else {
  //       print('Failed with status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw ('Something went wrong, please try again');
  //   }
  // }

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
      if (response.statusCode == 201) {
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
      if (response.statusCode == 201) {
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

  verifyLocation() {

  }
}
