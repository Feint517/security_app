// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxController {
  static LocationService get instance => Get.find();
  @override
  void onReady() {
    getLocationPermission();
  }

  //* Check if location services are enabled
  Future<void> checkIsEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  Future<void> getLocationPermission() async {
    LocationPermission permission;
    //* Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('Permission is denied, requesting permission...');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permission denied by user.');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Permission denied forever.');
      return Future.error('Location permissions are permanently denied.');
    }
  }

  Future<Position> getCurrentLocation() async {
    //* Check for location permissions
    getLocationPermission();

    //* Get the current position
    print('Getting current position...');
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
      //desiredAccuracy: LocationAccuracy.high,
    );
    print('Position obtained: $position');
    return position;
  }
}
