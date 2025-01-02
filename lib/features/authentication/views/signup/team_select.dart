// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/data/repositories/team_repository.dart';
import 'package:security_app/data/services/secure_storage.dart';
import 'package:security_app/features/authentication/controllers/signup/team_select_controller.dart';
import 'package:security_app/features/authentication/views/signup/widgets/team_tile.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TeamSelectScreen extends StatelessWidget {
  const TeamSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamSelectController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: THelperFunctions.screenWidth(),
                height: THelperFunctions.screenHeight() * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Before we continue, please choose the teams that you belong to from the following teams:',
                    ),
                    Obx(
                      () => ListView.separated(
                        physics:
                            const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
                        shrinkWrap: true,
                        itemCount: controller.teams.length,
                        separatorBuilder: (context, index) =>
                            const Gap(TSizes.spaceBtwSections / 2),
                        itemBuilder: (context, index) {
                          final team = controller.teams[index];
                          return TeamTile(
                            id: team.teamId,
                            teamName: team.name,
                            description: team.description,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: THelperFunctions.screenWidth() * 0.5,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Test'),
                ),
              ),
              const Gap(TSizes.spaceBtwInputFields),
              SizedBox(
                width: THelperFunctions.screenWidth() * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    final teamsList = controller.getSelectedTeamIds();
                    final userId = await SecureStorage.getUserId();
                    await TeamRepository.instance.addTeamMember(
                      teamIds: teamsList,
                      userId: userId!,
                    );
                    Get.offAll(() => const NavigationMenu());
                  },
                  child: const Text('Finish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}