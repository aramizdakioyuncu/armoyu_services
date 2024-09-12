import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ARMOYUWidgets {
  static void getSnackBar(getUsersResult) {
    try {
      Get.snackbar(
        "Sistem",
        "${getUsersResult['aciklama'].toString()}${getUsersResult['icerik'].length != 0 ? "\n${getUsersResult['icerik']}" : ""}",
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    } catch (e) {
      Get.snackbar(
        "Sistem",
        "${getUsersResult['aciklama'].toString()}${getUsersResult['icerik'] != null ? "\n${getUsersResult['icerik']}" : ""}",
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    }
  }
}
