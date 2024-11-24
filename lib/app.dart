import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/general_bindings.dart';
import 'features/authentication/views/login/login.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.ligtTheme,
      darkTheme: TAppTheme.darkTheme,
      //? when the app runs, it will automatically initiate all the methods in GeneralBindings
      initialBinding: GeneralBindings(),
      home: const LoginScreen(),
    );
  }
}
