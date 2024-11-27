import 'package:auth_process/app/routes/app_route.dart';
import 'package:auth_process/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appLightThemeData,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
