import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    // required this.imageLight,
    // required this.imageDark,
    required this.image,
  });

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              Lottie.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              // Image(
              //   image: AssetImage(
              //     dark ? imageDark : imageLight,
              //   ),
              //   width: THelperFunctions.screenWidth() * 0.6,
              // ),
              const Gap(TSizes.spaceBtwSections),

              //* title and subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(TSizes.spaceBtwItems),

              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(TTexts.sayContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
