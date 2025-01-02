// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/controllers/signup/team_select_controller.dart';
import '../../../../../utils/constants/colors.dart';

// class TeamTile extends StatelessWidget {
//   const TeamTile({
//     super.key,
//     required this.id,
//     required this.teamName,
//     required this.description,
//   });

//   final String id;
//   final String teamName;
//   final String description;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TeamSelectController());
//     return Obx(
//       () => GestureDetector(
//         onDoubleTap: () {
//           print('id = $id');
//           print('name = $teamName');
//           print('description = $description');
//         },
//         onTap: () {
//           controller.toggleSelection(id);
//         },
//         child: Container(
//           padding: const EdgeInsets.all(TSizes.md),
//           width: THelperFunctions.screenWidth() * 0.9,
//           height: 100,
//           decoration: BoxDecoration(
//             color:
//                 controller.isSelected(id) ? Colors.green : Colors.transparent,
//             borderRadius: BorderRadius.circular(37),
//             border: Border.all(
//               color: TColors.primary,
//               width: 2.0,
//             ),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 teamName,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const Gap(TSizes.sm),
//               Row(
//                 children: [
//                   const Text('Description:'),
//                   Flexible(
//                     child: Text(
//                       description,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class TeamTile extends StatelessWidget {
  const TeamTile({
    super.key,
    required this.id,
    required this.teamName,
    required this.description,
  });

  final String id;
  final String teamName;
  final String description;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamSelectController());

    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.toggleSelection(id);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: controller.isSelected(id)
                ? Colors.green.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: controller.isSelected(id) ? Colors.green : TColors.primary,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //* Icon Indicating Selection State
              Icon(
                controller.isSelected(id)
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: controller.isSelected(id) ? Colors.green : Colors.grey,
                size: 32,
              ),
              const SizedBox(width: 16),

              //* Text Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Team Name
                    Text(
                      teamName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    //* Description
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
