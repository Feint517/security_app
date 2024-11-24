class CustomFormatException implements Exception {
  final String message;

  //? default constructor with a generic error message
  const CustomFormatException([
    this.message =
        'An unexpected format error occured, please check your input.',
  ]);

  //? create a format exception from a specific error message
  factory CustomFormatException.fromMessage(String message) {
    return CustomFormatException(message);
  }

  //? get the corresponding error message
  String get formattedMessage => message;

  //? create a format exception from a specific error code
  factory CustomFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CustomFormatException(
            'The email address format is invalid, please enter a valid email.');
      case 'invalid-phone-number-format':
        return const CustomFormatException(
            'Theprovided phone number format is invalid.');
      case 'invalid-date-format':
        return const CustomFormatException('The date format is invalid.');
      case 'invalid-url-format':
        return const CustomFormatException('The URL format is invalid.');
      case 'invalid-credit-card-format':
        return const CustomFormatException(
            'The credit card format is invalid.');
      case 'invalid-numeric-format':
        return const CustomFormatException(
            'The input should be a valid numeric format.');
      default:
        return const CustomFormatException('Unknown error');
    }
  }
}
