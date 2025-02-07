// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:security_app/features/posting/views/widgets/home_appbar.dart';
import 'package:security_app/features/posting/views/widgets/project_tile.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/projects_controller.dart';
import 'widgets/project_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              height: THelperFunctions.screenHeight(),
              child: Column(
                children: [
                  const HomeAppBar(),
                  const Gap(TSizes.spaceBtwSections / 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SizedBox(
                      width: THelperFunctions.screenWidth() * 0.9,
                      height: THelperFunctions.screenHeight() * 0.8,
                      child: Column(
                        children: [
                          const Gap(TSizes.spaceBtwSections / 2),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Projects list:',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Obx(
                            () => ListView.separated(
                              physics:
                                  const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
                              shrinkWrap: true,
                              itemCount: controller.projects.length,
                              separatorBuilder: (context, index) =>
                                  const Gap(TSizes.spaceBtwSections / 2),
                              itemBuilder: (context, index) {
                                final project = controller.projects[index];
                                return ProjectTile(
                                  projectCode: project.projectCode,
                                  projectId: project.projectId,
                                  name: project.name,
                                  teamId: project.teamId,
                                  budget: project.budget,
                                  startDate: project.startDate,
                                  timeline: project.timeline,
                                  advancementRate: project.advancementRate,
                                  onTap: () => Get.bottomSheet(
                                    ProjectDetailsPopup(
                                      projectCode: project.projectCode,
                                      projectId: project.projectId,
                                      name: project.name,
                                      teamId: project.teamId,
                                      budget: project.budget,
                                      startDate: project.startDate,
                                      timeline: project.timeline,
                                      advancementRate: project.advancementRate,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
