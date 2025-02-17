import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:security_app/common/widgets/appbar/appbar.dart';
import 'package:security_app/utils/constants/colors.dart';
import 'widgets/notes_section.dart';

class ProjectDetailsScrollable extends StatelessWidget {
  const ProjectDetailsScrollable({
    super.key,
    required this.projectData,
  });

  final Map<String, dynamic> projectData;

  @override
  Widget build(BuildContext context) {
    final date1 = DateTime.parse(projectData['timeline']);
    final date2 = DateTime.parse(projectData['startDate']);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          projectData['name'] ?? "Project Details",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                "Project Info",
              ),
              Text(
                "Project code: ${projectData['projectCode']}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Budget: \$${projectData['budget']}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Timeline: ${DateFormat('yMMMd').format(date1)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Start Date: ${DateFormat('yMMMd').format(date2)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Advancement Rate: ${projectData['advancementRate']}%",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Gap(16),
              _buildSectionTitle("Team Members"),
              _buildTeamMembers(projectData['team']['members']),
              const SizedBox(height: 16),
              _buildSectionTitle("Notes"),
              NotesSection(projectCode: projectData['projectCode']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
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
          leading: const Icon(
            Icons.person,
            color: TColors.primary,
          ),
          title: Text(fullName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Team Member"),
        );
      }).toList(),
    );
  }
}
