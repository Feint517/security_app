import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:security_app/features/posting/views/home.dart';
import 'package:security_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';

class PinsScreen extends StatelessWidget {
  const PinsScreen({super.key, required this.pin1, required this.pin2});

  final String pin1;
  final String pin2;

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Your Pin codes are:',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(TSizes.spaceBtwSections),
                    Text(
                      pin1,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(TSizes.spaceBtwSections),
                    Text(
                      pin2,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(TSizes.spaceBtwSections),
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
                width: THelperFunctions.screenWidth() * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const HomeScreen());
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
