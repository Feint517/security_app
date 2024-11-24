import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security_app/data/services/location_service.dart';
import 'utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationService());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceBtwSections,
          ),
          child: Center(
            child: SizedBox(
              width: double.infinity, //? to make the sized button full width
              child: OutlinedButton(
                onPressed: () async {
                  controller.testLocation();
                },
                child: const Text('Test Location'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
