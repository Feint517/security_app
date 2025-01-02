// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:security_app/data/repositories/project_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/data/user/project_model.dart';

class ProjectsController extends GetxController {
  @override
  void onReady() async {
    final userId = await SecureStorage.getUserId();
    fetchProjectsByUserId(userId: userId!);
  }

  RxList<ProjectModel> projects = <ProjectModel>[].obs;

  void fetchAvailableProjects() async {
    try {
      projects.value = await ProjectRepository.instance.fetchAllProjects();
      print('projects = $projects');
      print(projects[0].projectId);
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }

  void fetchProjectsByUserId({required String userId}) async {
    try {
      projects.value = await ProjectRepository.instance
          .fetchProjectsByUserId(userId: userId);
      print('projects = ${projects[0].startDate}');
      //print('id = ${projects[0].projectId}');
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }
}
