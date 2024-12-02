import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestapiController extends GetxController {
  var apikeyController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var passcordController = TextEditingController().obs;

  var statusController = Rx<bool?>(null);

//Profile

  var useravatarController =
      "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu128.png".obs;

  var savestaus = false.obs;
  var loginstaus = false.obs;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

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
