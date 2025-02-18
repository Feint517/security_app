// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/data/repositories/project_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/data/user/project_model.dart';
import 'package:security_app/utils/constants/api_constant.dart';

class ProjectsController extends GetxController {
  static ProjectsController get instance => Get.find();

  @override
  void onReady() async {
    final userId = await SecureStorage.getUserId();
    fetchProjectsByUserId(userId: userId!);
  }

  RxList<ProjectModel> projectsList = <ProjectModel>[].obs;
  var notes = <Map<String, dynamic>>[].obs;
  var isPosting = false.obs;
  final noteController = TextEditingController();

  void fetchAvailableProjects() async {
    try {
      projectsList.value = await ProjectRepository.instance.fetchAllProjects();
      print('projects = $projectsList');
      print(projectsList[0].projectId);
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }

  void fetchProjectsByUserId({required String userId}) async {
    try {
      projectsList.value = await ProjectRepository.instance
          .fetchProjectsByUserId(userId: userId);
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }

  Future<Map<String, dynamic>> fetchProjectDetails(
      {required String projectCode}) async {
    try {
      final body = {"projectCode": projectCode};
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.fetchProjectDetails,
        method: 'post',
        body: body,
      );
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(jsonResponse);
        return jsonResponse;

      } else {
        Get.snackbar("Error", "Failed to load notes");
        return jsonResponse;
      }
    } catch (error) {
      print('Error fetching teams: $error');
      return {"error": "Failed to load project details"};
    }
  }
}
