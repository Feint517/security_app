import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectTile extends StatelessWidget {
  final String projectId;
  final String projectCode;
  final String name;
  final String teamId;
  final int budget;
  final String startDate;
  final String timeline;
  final int advancementRate;
  final VoidCallback onTap;

  const ProjectTile({
    super.key,
    required this.projectId,
    required this.projectCode,
    required this.name,
    required this.teamId,
    required this.budget,
    required this.startDate,
    required this.timeline,
    required this.advancementRate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String formattedStartDate =
        DateFormat('dd MMMM yyyy').format(DateTime.parse(startDate));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Project Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            //* Advancement Rate with Progress Bar
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: advancementRate / 100,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$advancementRate%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),

            //* Budget and Timeline Row
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget: €${budget.toString()}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Timeline: $timeline',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            //* Start Date
            const SizedBox(height: 8),
            Text(
              'Start Date: $formattedStartDate',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
