// ignore_for_file: unnecessary_brace_in_string_interps

class APIConstants {
  static const String url = 'http://192.168.43.50:3000/';
  static const String ping = '${url}ping';
  static const String registration = '${url}auth/register';
  static const String verifyCredentials = '${url}auth/validate-credentials';
  static const String verifyPins = '${url}auth/validate-pins';
}
