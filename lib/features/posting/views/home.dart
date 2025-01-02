// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:security_app/data/repositories/authentication_repository.dart';
import 'package:security_app/features/personalisation/controllers/user_controller.dart';
import 'package:security_app/features/posting/views/widgets/home_appbar.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
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
                                // final refreshToken = await SecureStorage.getRefreshToken();
                                // final response = await AuthenticationRepository
                                //     .instance
                                //     .verifyRefreshToken(refreshToken!);
                                // print('response = $response');
                                await AuthenticationRepository.instance
                                    .refreshTokens();
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
