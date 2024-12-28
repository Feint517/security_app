// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:security_app/common/styles/loaders.dart';
import 'package:security_app/data/services/location_service.dart';

import 'data/repositories/authentication_repository.dart';
import 'utils/constants/animations.dart';
import 'utils/popups/fullscreen_loader.dart';

class TestingController extends GetxController {
  void checkPermission() async {
    try {
      await LocationService.instance.getLocationPermission();
    } catch (e) {
      print('Error: $e');
    }
  }

  void checkIsEnabled() async {
    try {
      await LocationService.instance.checkIsEnabled();
      CustomLoaders.successSnackBar(title: 'thanks');
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Oops',
        message: 'Please enable your location service!',
      );
      print('Error: $e');
    }
  }

  void checkLocation() async {
    try {
      CustomFullscreenLoader.openLoadingDialog(
        'Please wait...',
        TAnimations.check,
      );
      final position = await LocationService.instance.getCurrentLocation();

      //* verify user location
      final response1 = await AuthenticationRepository.instance.verifyLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
      final status1 = response1.$1;
      final json1 = response1.$2;

      if (status1 == 200) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.successSnackBar(
          title: 'Hooray',
          message: json1['message'].toString(),
        );
        return;
      }

      if (status1 != 200) {
        final error = json1['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void checkUserCredentials(String email, String password) async {
    final response2 = await AuthenticationRepository.instance
          .verifyCredentials(email, password);
      final status2 = response2.$1;
      final json2 = response2.$2;

      if (status2 != 200) {
        final error = json2['error'];
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: error['message'],
        );
        return;
      }
      CustomLoaders.successSnackBar(
        title: 'Hooray',
        message: json2['message'],
      );
  }
}
