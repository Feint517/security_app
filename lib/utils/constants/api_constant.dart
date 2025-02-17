// ignore_for_file: unnecessary_brace_in_string_interps

class APIConstants {
  static const String url = 'https://unisecurityproject.vercel.app/';
  static const String urlOld = 'http://192.168.1.8:3000/';
  static const String urlMac = 'http://10.0.2.2:3000/';
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
  static const String fetchAllTeams = '${url}teams/fetch';
  static const String getTeamMembers = '${url}teams/members';
  static const String addTeamMember = '${url}teams/add-member';
  static const String fetchAllProjects = '${url}projects/fetch';
  static const String fetchProjectsByUserId = '${url}projects/user';
  static const String fetchProjectDetails = '${url}projects/details';
  static const String addNote = '${url}projects/add-note';
  static const String deleteNode = '${url}projects/delete-note';
  static const String updateAdvancementRate =
      '${url}projects/update-advancement-rate';
  static const String updatePassword = '${url}auth/change-password';
}
