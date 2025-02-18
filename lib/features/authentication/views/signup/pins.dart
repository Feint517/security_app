import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/features/authentication/controllers/signup/team_select_controller.dart';
import 'package:security_app/features/authentication/views/signup/team_select.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';

class PinsScreen extends StatelessWidget {
  const PinsScreen({super.key, required this.pin1, required this.pin2});

  final String pin1;
  final String pin2;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamSelectController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: CustomHelperFunctions.screenWidth(),
                height: CustomHelperFunctions.screenHeight() * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Pin codes are:',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(CustomSizes.spaceBtwSections),
                    Text(
                      pin1,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(CustomSizes.spaceBtwSections),
                    Text(
                      pin2,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(CustomSizes.spaceBtwSections),
                    Text(
                      'Save them somewhere safe!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: CustomHelperFunctions.screenWidth() * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    controller.searchForTeams();
                    Get.to(() => const TeamSelectScreen());
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
