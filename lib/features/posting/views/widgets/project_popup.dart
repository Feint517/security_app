import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';

class ProjectDetailsPopup extends StatelessWidget {
  const ProjectDetailsPopup({
    super.key,
    required this.projectId,
    required this.projectCode,
    required this.name,
    required this.teamId,
    required this.budget,
    required this.startDate,
    required this.timeline,
    required this.advancementRate,
  });

  final String projectId;
  final String projectCode;
  final String name;
  final String teamId;
  final int budget;
  final String startDate;
  final String timeline;
  final int advancementRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: THelperFunctions.screenHeight() * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Project's info",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Team: ......"),
              Text('Budget: €${budget.toString()}'),
              Text('Timeline: $timeline'),
              Text(
                  'Start Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(startDate))}'),
              const SizedBox(height: 10),

              //* Members List
              const Text("Team Members:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  2,
                  (index) {
                    return Text("member $index");
                  },
                ),
              ),
              const SizedBox(height: 10),

              //* Progress Slider
              const Text("Advancement Rate: ....."),
              Slider(
                value: 20,
                min: 0,
                max: 100,
                divisions: 20,
                label: '$advancementRate',
                onChanged: (value) {},
              ),

              //* Notes TextField
              TextFormField(
                //controller: notesController,
                decoration: const InputDecoration(labelText: "Notes"),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
