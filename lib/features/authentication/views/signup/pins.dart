import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Pin codes are',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(TSizes.spaceBtwSections),
              Text(pin1),
              const Gap(TSizes.spaceBtwSections),
              Text(pin2),
            ],
          ),
        ),
      ),
    );
  }
}
