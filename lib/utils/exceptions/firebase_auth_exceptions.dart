class CustomFirebaseAuthException implements Exception {
  final String code;

  CustomFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered, please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid, please enter a valid email address.';
      case 'weak-password':
        return 'The password used is too weak, please use a stronger password.';
      case 'user-disabled':
        return 'This account is disabled.';
      case 'user-not-found':
        return 'Invalid login details, user not found.';
      case 'wrong-password':
        return 'Incorrect password, please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID.';
      case 'quota-exceeded':
        return 'Quota exceeded, please try again later.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      default:
        return 'Unknown error.';
    }
  }
}
