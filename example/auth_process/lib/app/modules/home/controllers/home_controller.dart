import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  void changethememode() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    isDarkMode.value = Get.isDarkMode;
  }
}
