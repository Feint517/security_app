import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorage {
  static SecureStorage get instance => Get.find();
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokensAndId({
    required String userId,
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'userId', value: userId);
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<void> saveAccessToken({required String accessToken}) async {
    await _storage.write(key: 'accessToken', value: accessToken);
  }

  static Future<void> saveRefreshToken({required String refreshToken}) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: 'userId');
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  static Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}
