// ignore_for_file: unnecessary_brace_in_string_interps

class APIConstants {
  static const String url = 'http://192.168.1.2:3000/';
  static const String ping = '${url}api/ping';
  static const String registration = '${url}auth/register';
  static const String verifyCredentials = '${url}auth/validate-credentials';
  static const String verifyPins = '${url}auth/validate-pins';
  static const String verifyLocation = '${url}auth/validate-location';
  static const String logout = '${url}auth/logout';
  static const String verifyRefreshToken = '${url}auth/check-refresh-token';
  static const String protectedEndpoint = '';
  static const String refreshTokens = '${url}auth/refresh-tokens';
  static const String fetchUserData = '${url}user/fetch/:id';
}
