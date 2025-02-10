// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:security_app/data/repositories/project_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/data/user/project_model.dart';
import 'package:security_app/data/user/user_model.dart';

import '../../../common/styles/loaders.dart';

class ProjectsController extends GetxController {
  @override
  void onReady() async {
    final userId = await SecureStorage.getUserId();
    fetchProjectsByUserId(userId: userId!);
  }

  RxList<ProjectModel> projectsList = <ProjectModel>[].obs;
  List<UserModel> contributorsList = <UserModel>[];

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
      print('projects = ${projectsList[0].startDate}');
      //print('id = ${projects[0].projectId}');
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }

  void fetchProjectDetails({required String projectId}) async {
    try {
      final response = await ProjectRepository.instance
          .fetchProjectDetails(projectId: projectId);

      if (response.$1 == 200) {
        //* create a list of contributors(team members)
        List<UserModel> contributors = (response.$2['team']['members'] as List)
            .map((projectJson) => UserModel.fromSnapshot(projectJson))
            .toList();
        print(contributors[0].username);
        contributorsList = contributors;
      }
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }
}
