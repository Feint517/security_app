import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:security_app/app.dart';
import 'package:security_app/data/services/location_service.dart';
import 'data/repositories/authentication_repository.dart';

Future<void> main() async {
  //* Suppress debugPrint logs
  debugPrint = (String? message, {int? wrapWidth}) {};
  ui.PlatformDispatcher.instance.onPointerDataPacket =
      (ui.PointerDataPacket packet) {};

  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //* init local storage
  await GetStorage.init();

  //* await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(LocationService());
  Get.put(AuthenticationRepository()); //? invoke the authentication repo

  runApp(const App());
}
