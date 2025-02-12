import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'widgets/notes_section.dart';

class ProjectDetailsScrollable extends StatelessWidget {
  const ProjectDetailsScrollable({
    super.key,
    required this.projectData,
  });

  final Map<String, dynamic> projectData;

  // final Map<String, dynamic> projectData = {
  //   "name": 'test',
  //   "budget": 1000,
  //   "timeline": 'idk',
  //   "startDate": 'idk',
  //   "advancementRate": 69,
  //   "team": {
  //     "members": [
  //       {
  //         "firstName": "arselene",
  //         "lastName": "meghlaoui",
  //       },
  //       {
  //         "firstName": "saly",
  //         "lastName": "benariba",
  //       }
  //     ],
  //   },
  //   "notes": [
  //     {
  //       "user": {
  //         "_id": "67a91348dbfbbaf589bf0c64",
  //         "firstName": "Arselene",
  //         "lastName": "Meghlaoui",
  //         "email": "arselene.main@gmail.com"
  //       },
  //       "content": "This project needs an update on the dataset.1",
  //       "_id": "67abf8dec7603b1bc969d77a",
  //       "createdAt": "2025-02-12T01:26:54.996Z"
  //     },
  //     {
  //       "user": {
  //         "_id": "67a91348dbfbbaf589bf0c64",
  //         "firstName": "Arselene",
  //         "lastName": "Meghlaoui",
  //         "email": "arselene.main@gmail.com"
  //       },
  //       "content": "This project needs an update on the dataset.1",
  //       "_id": "67abf8dec7603b1bc969d77a",
  //       "createdAt": "2025-03-12T01:26:54.996Z"
  //     },
  //     {
  //       "user": {
  //         "_id": "67a91348dbfbbaf589bf0c64",
  //         "firstName": "Arselene",
  //         "lastName": "Meghlaoui",
  //         "email": "arselene.main@gmail.com"
  //       },
  //       "content": "This project needs an update on the dataset.1",
  //       "_id": "67abf8dec7603b1bc969d77a",
  //       "createdAt": "2025-03-08T01:26:54.996Z"
  //     },
  //   ]
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(projectData['name'] ?? "Project Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Project Info"),
            Text("Project code: ${projectData['projectCode']}"),
            Text("Budget: \$${projectData['budget']}"),
            Text("Timeline: ${projectData['timeline']}"),
            Text("Start Date: ${projectData['startDate']}"),
            Text("Advancement Rate: ${projectData['advancementRate']}%"),
            const Gap(16),
            _buildSectionTitle("Team Members"),
            _buildTeamMembers(projectData['team']['members']),
            const SizedBox(height: 16),
            _buildSectionTitle("Notes"),
            NotesSection(projectCode: projectData['projectCode']),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildTeamMembers(List<dynamic> members) {
    if (members.isEmpty) {
      return const Text("No team members assigned.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: members.map((member) {
        final fullName = "${member['firstName']} ${member['lastName']}";
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(fullName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Team Member"),
        );
      }).toList(),
    );
  }

  // Widget _buildNotesList(List<dynamic> notes) {
  //   if (notes.isEmpty) {
  //     return const Text("No notes available.");
  //   }

  //   //* Sort notes by date (newest first)
  //   notes.sort((a, b) => DateTime.parse(b['createdAt'])
  //       .compareTo(DateTime.parse(a['createdAt'])));

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: notes.map((note) {
  //       final authorName =
  //           "${note['user']['firstName']} ${note['user']['lastName']}";
  //       final content = note['content'];
  //       final createdAt = note['createdAt'];

  //       //* Format the createdAt date
  //       final date = DateTime.parse(createdAt);
  //       final formattedDate = DateFormat('yMMMd').add_jm().format(date);

  //       return Card(
  //         child: ListTile(
  //           leading: const Icon(Icons.note),
  //           title: Text(content,
  //               style: const TextStyle(fontWeight: FontWeight.bold)),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("By: $authorName"),
  //               Text("Date: $formattedDate",
  //                   style: const TextStyle(fontSize: 12)),
  //             ],
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
}
