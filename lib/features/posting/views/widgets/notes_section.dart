import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/notes_controller.dart';

class NotesSection extends StatelessWidget {
  final String projectCode;

  const NotesSection({
    super.key,
    required this.projectCode,
  });

  @override
  Widget build(BuildContext context) {
    //* Initialize GetX Controller
    final controller = Get.put(NotesController(projectCode));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Notes List
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.notes.map((note) {
              final authorName =
                  "${note['user']['firstName']} ${note['user']['lastName']}";
              final content = note['content'];
              final createdAt = note['createdAt'];

              //* Format the createdAt date
              final date = DateTime.parse(createdAt);
              final formattedDate = DateFormat('yMMMd').add_jm().format(date);

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(content,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("By: $authorName"),
                      Text("Date: $formattedDate",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const Gap(10),
        //* Text Field for New Note
        TextFormField(
          controller: controller.noteController,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: "Write a note...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 8.0),
        //* Submit Button
        Center(
          child: Obx(
            () => ElevatedButton.icon(
              onPressed:
                  controller.isPosting.value ? null : controller.postNote,
              icon: controller.isPosting.value
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.send,
                    ),
              label: const Text("Post Note"),
            ),
          ),
        ),
      ],
    );
  }
}