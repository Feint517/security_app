class CustomPlatformException implements Exception {
  final String code;

  CustomPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials, please check your information.';
      case 'too-many-requests':
        return 'Thoo many requests, please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'The passwod provided is invalid.';
      case 'invalid-phone-number':
        return 'The phone number provided is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired.';
      case 'uid-already-exists':
        return 'The provided user id is already in use by another user.';
      case 'sign-in-failed':
        return 'Sign in failed, please try again.';
      case 'network-request-failed':
        return 'Network request failed, please check your internect connection.';
      case 'internal-error':
        return 'Internal error, please try again later.';
      case 'invalid-verification-code':
        return 'Invalid verification code.';
      case 'invalid-verification-id':
        return 'Invalid verification id.';
      default:
        return 'Unknown error.';
    }
  }
}
