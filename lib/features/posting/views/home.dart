// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:security_app/data/repositories/server_repository.dart';
import 'package:security_app/features/posting/views/widgets/home_appbar.dart';
import 'package:security_app/testing_controller.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../common/styles/loaders.dart';
import '../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testController = Get.put(TestingController());
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
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                final response = await ServerRepository.instance
                                    .isServerRunning();
                                if (response == true) {
                                  CustomLoaders.successSnackBar(
                                    title: 'Hooray',
                                    message: 'Server is up and running.',
                                  );
                                } else {
                                  CustomLoaders.warningSnackBar(
                                      title: 'Server is not responding',
                                      message:
                                          'Some functionalities might be limited');
                                }
                              },
                              child: const Text('Test'),
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
