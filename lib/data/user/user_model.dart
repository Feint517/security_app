class UserModel {
  final String userId;
  String firstName;
  String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  //final String password;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    //this.password = '',
  });

  //* helper function to get the full name
  String get fullName => '$firstName $lastName';

  //* static function to split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //* static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String cameCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$cameCaseUsername"; //? add cwt_ prefix
    return usernameWithPrefix;
  }

  //* static function to create an empty user model
  static UserModel empty() => UserModel(
        userId: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        //password: '',
      );

  factory UserModel.fromSnapshot(
    Map<String, dynamic>? document,
  ) {
    if (document != null) {
      return UserModel(
        userId: document['_id'],
        firstName: document['firstName'],
        lastName: document['lastName'],
        username: document['username'],
        email: document['email'],
        phoneNumber: document['phoneNumber'],
      );
    } else {
      return UserModel.empty();
    }
  }
}
