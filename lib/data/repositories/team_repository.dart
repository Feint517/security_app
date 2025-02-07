// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/data/user/team_model.dart';
import 'package:http/http.dart' as http;
import 'package:security_app/data/user/user_model.dart';
import '../../utils/constants/api_constant.dart';

class TeamRepository extends GetxController {
  static TeamRepository get instance => Get.find();

  Future<List<TeamModel>> oldFetchAllTeams() async {
    try {
      final response = await http.get(
        Uri.parse(APIConstants.fetchAllTeams),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        List<TeamModel> teams = (jsonResponse as List)
            .map((teamJson) => TeamModel.fromJson(teamJson))
            .toList();

        print('Fetching teams.....');
        print('Numbers of teams found = ${teams.length}');
        print('jsonResponse = $jsonResponse');

        return teams;
      } else {
        throw Exception('Failed to fetch teams: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching teams');
    }
  }

  Future<List<TeamModel>> fetchAllTeams() async {
    try {
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.fetchAllTeams,
        method: 'get',
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<TeamModel> teams = (jsonResponse as List)
            .map((teamJson) => TeamModel.fromJson(teamJson))
            .toList();

        print('----------------------Teams Fetched Successfuly');
        print('Numbers of teams found = ${teams.length}');
        return teams;
      } else {
        throw Exception('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching teams');
    }
  }

  Future<List<UserModel>> getTeamMembers({required String teamId}) async {
    final body = {
      "teamId": teamId,
    };

    try {
      final response = await http.post(
        Uri.parse(APIConstants.getTeamMembers),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timed out. Please try again.');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        List<UserModel> members = (jsonResponse['members'] as List)
            .map((teamJson) => UserModel.fromSnapshot(teamJson))
            .toList();

        print('Number of members found = ${members.length}');
        //print(members[0].username);

        return members;
      } else {
        throw Exception('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching user data');
    }
  }

  Future<void> addTeamMember(
      {required List<String> teamIds, required String userId}) async {
    final body = {"teamIds": teamIds, "userId": userId};

    try {
      final response = await http.post(
        Uri.parse(APIConstants.addTeamMember),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timed out. Please try again.');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('adding....');
        print(jsonResponse);
      } else {
        throw Exception('Failed to add member: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching user data');
    }
  }
}
