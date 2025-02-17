// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/common/styles/loaders.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import '../../../utils/constants/api_constant.dart';

class NotesController extends GetxController {
  final String projectCode;
  NotesController(this.projectCode);

  String? loggedInUserId;

  @override
  void onReady() async {
    loggedInUserId = await SecureStorage.getUserId();
  }

  var notes = <Map<String, dynamic>>[].obs;
  var isPosting = false.obs;
  final noteController = TextEditingController();

  Future<void> fetchNotes({required String projectCode}) async {
    try {
      final body = {"projectCode": projectCode};
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.fetchProjectDetails,
        method: 'post',
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        notes.value =
            List<Map<String, dynamic>>.from(jsonResponse["project"]["notes"]);
        notes.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));
        print(notes[0]);
      } else {
        //Get.snackbar("Error", "Failed to load notes");
        CustomLoaders.errorSnackBar(
          title: 'Error!',
          message: 'Failed to poste note.',
        );
      }
    } catch (e) {
      print("Error fetching notes: $e");
    }
  }

  Future<void> postNote() async {
    final content = noteController.text.trim();
    if (content.isEmpty) return;

    isPosting.value = true;

    try {
      final body = {
        "projectCode": projectCode,
        "content": content,
      };
      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.addNote,
        method: 'post',
        body: body,
      );

      if (response.statusCode == 201) {
        noteController.clear();
        fetchNotes(projectCode: projectCode); //? Refresh the list after posting
      } else {
        CustomLoaders.errorSnackBar(
          title: 'Error!',
          message: 'Failed to poste note.',
        );
        //Get.snackbar("Error", "Failed to post note");
      }
    } catch (e) {
      print("Error posting note: $e");
    } finally {
      isPosting.value = false;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      final body = {
        "projectCode": projectCode,
        "noteId": noteId,
      };

      final response =
          await AuthenticationRepository.instance.authenticatedRequest(
        endpoint: APIConstants.deleteNode,
        method: 'delete',
        body: body,
      );

      if (response.statusCode == 200) {
        //* Remove the note from the list
        notes.removeWhere((note) => note['_id'] == noteId);
        //Get.snackbar("Success", "Note deleted successfully");
        CustomLoaders.successSnackBar(
          title: 'Success!',
          message: 'Note deleted successfully',
        );
      } else {
        //Get.snackbar("Error", "Failed to delete note");
        CustomLoaders.errorSnackBar(
          title: 'Error!',
          message: 'Failed to poste note.',
        );
      }
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
