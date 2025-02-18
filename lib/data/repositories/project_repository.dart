// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:security_app/data/user/project_model.dart';
import '../../utils/constants/api_constant.dart';
import 'authentication_repository.dart';

class ProjectRepository extends GetxController {
  static ProjectRepository get instance => Get.find();

  Future<List<ProjectModel>> fetchAllProjects() async {
    try {
      final response = await http.get(
        Uri.parse(APIConstants.fetchAllProjects),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        List<ProjectModel> projects = (jsonResponse as List)
            .map((projectJson) => ProjectModel.fromJson(projectJson))
            .toList();

        print('Fetching projects.....');
        print('Numbers of projects found = ${projects.length}');
        return projects;
      } else {
        throw Exception('Failed to fetch teams: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching teams');
    }
  }

  Future<List<ProjectModel>> fetchProjectsByUserId(
      {required String userId}) async {
    final body = {"userId": userId};
    try {
      final response = await http.post(
        Uri.parse(APIConstants.fetchProjectsByUserId),
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

        List<ProjectModel> projects = (jsonResponse as List)
            .map((projectJson) => ProjectModel.fromJson(projectJson))
            .toList();

        print('Fetching projects.....');
        print('Numbers of projects found = ${projects.length}');
        print('jsonResponse = $jsonResponse');
        return projects;
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch teams: ${response.body}');
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<void> updateAdvancementRate(
      {required String projectId, required int newRate}) async {
    final body = {
      "projectId": projectId,
      "advancementRate": newRate,
    };

    try {
      final response = await http.put(
        Uri.parse(APIConstants.updateAdvancementRate),
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
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  Future<(int status, dynamic response)> fetchProjectDetails(
      {required String projectId}) async {
    try {
      final body = {"projectId": projectId};

      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.fetchProjectDetails,
        method: 'POST',
        body: body,
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return (response.statusCode, json as dynamic);
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return (response.statusCode, json as dynamic);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching user data');
    }
  }
}
