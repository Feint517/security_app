import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:security_app/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:security_app/features/posting/views/widgets/home_appbar.dart';
import '../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  HomeAppBar(),
                  Gap(TSizes.spaceBtwSections / 2),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                    child: Text(
                      'Latest posts',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Gap(TSizes.spaceBtwInputFields),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
