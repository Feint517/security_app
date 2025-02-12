// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:security_app/features/posting/controllers/notes_controller.dart';
import 'package:security_app/features/posting/views/project_details_scrollable.dart';
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
    final notesController = Get.put(NotesController('CPR2T'));
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
                              itemCount: controller.projectsList.length,
                              separatorBuilder: (context, index) =>
                                  const Gap(TSizes.spaceBtwSections / 2),
                              itemBuilder: (context, index) {
                                final project = controller.projectsList[index];
                                return ProjectTile(
                                  projectCode: project.projectCode,
                                  projectId: project.projectId,
                                  name: project.name,
                                  teamId: project.teamId,
                                  budget: project.budget,
                                  startDate: project.startDate,
                                  timeline: project.timeline,
                                  advancementRate: project.advancementRate,
                                  onTap: () async {
                                    final projectData =
                                        await controller.fetchProjectDetails(
                                      projectCode: project.projectCode,
                                    );
                                    notesController.fetchNotes(
                                        projectCode: project.projectCode);
                                    Get.to(
                                      () => ProjectDetailsScrollable(
                                        projectData: projectData['project'],
                                      ),
                                    );
                                    // controller.fetchProjectDetails(
                                    //     projectId: project.projectId);
                                    // Get.bottomSheet(
                                    //   ProjectDetailsPopup(
                                    //     projectCode: project.projectCode,
                                    //     projectId: project.projectId,
                                    //     name: project.name,
                                    //     teamId: project.teamId,
                                    //     budget: project.budget,
                                    //     startDate: project.startDate,
                                    //     timeline: project.timeline,
                                    //     advancementRate:
                                    //         project.advancementRate,
                                    //     teamMembers:
                                    //         controller.contributorsList,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                // controller.fetchProjectDetails(
                                //   projectId: '6776eee5782c793ccfc97c10',
                                // );
                                //notesController.fetchNotes();
                                controller.fetchProjectDetails(
                                    projectCode: 'CPR2T');
                              },
                              child: const Text(
                                'test',
                                style: TextStyle(color: Colors.white),
                              ),
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
