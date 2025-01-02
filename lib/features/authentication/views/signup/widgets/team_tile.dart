// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/controllers/signup/team_select_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

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
        onDoubleTap: () {
          print('id = $id');
          print('name = $teamName');
          print('description = $description');
        },
        onTap: () {
          controller.toggleSelection(id);
        },
        child: Container(
          padding: const EdgeInsets.all(TSizes.md),
          width: THelperFunctions.screenWidth() * 0.9,
          height: 100,
          decoration: BoxDecoration(
            color:
                controller.isSelected(id) ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(37),
            border: Border.all(
              color: TColors.primary,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                teamName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(TSizes.sm),
              Row(
                children: [
                  const Text('Description:'),
                  Flexible(
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
