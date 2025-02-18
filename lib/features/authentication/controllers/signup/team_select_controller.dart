// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:security_app/data/repositories/team_repository.dart';
import '../../../../data/user/team_model.dart';

class TeamSelectController extends GetxController {
  RxList<TeamModel> teams = <TeamModel>[].obs;
  var selectedTeams = <String, bool>{}.obs;

  Future<void> searchForTeams() async {
    try {
      teams.value = await TeamRepository.instance.fetchAllTeams();
      print(teams);
    } catch (error) {
      print('Error fetching teams: $error');
    }
  }

  void toggleSelection(String teamId) {
    if (selectedTeams.containsKey(teamId)) {
      selectedTeams[teamId] = !selectedTeams[teamId]!;
    } else {
      selectedTeams[teamId] = true; //? Mark as selected
    }
  }

  bool isSelected(String id) {
    return selectedTeams[id] ?? false;
  }

  List<String> getSelectedTeamIds() {
    return selectedTeams.entries
        .where((entry) => entry.value) //? Keep only entries with value == true
        .map((entry) => entry.key) //? Extract the keys (IDs)
        .toList();
  }
}
