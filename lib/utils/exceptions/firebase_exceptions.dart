class CustomFirebaseException implements Exception {
  final String code;

  CustomFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occured, please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect, please try again.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'This account is disabled.';
      case 'user-not-found':
        return 'No user was found for the given email or UID.';
      case 'invalid-email':
        return 'The email address provided is invalid, please enter a valid email address.';
      case 'email-already-in-use':
        return 'The email address is already registered, please use a different email.';
      case 'wrong-password':
        return 'Incorrect password, please check your password and try again.';
      case 'weak-password':
        return 'The password used is too weak, please use a stronger password.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      default:
        return 'Unknown error.';
    }
  }
}
