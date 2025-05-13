import 'package:armoyu_services/armoyu_services.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:armoyu_services/core/models/ARMOYU/user.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var apikeyController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var passcordController = TextEditingController().obs;
  var barriertokenController = TextEditingController().obs;

//Profile

  var useravatarController =
      "https://storage.aramizdakioyuncu.com/galeri/ana-yapi/armoyu128.png".obs;

  var savestaus = false.obs;
  var loginstaus = false.obs;
  var addfriendstaus = false.obs;
  var registerstaus = false.obs;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  static void getSnackBar(String description, dynamic descriptiondetail) {
    try {
      Get.snackbar(
        "Sistem",
        description,
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    } catch (e) {
      log("Hata");
    }
  }

  Future<void> login() async {
    LoginResponse getUsersResult = await ARMOYU.service.authServices.login(
      username: usernameController.value.text,
      password: passcordController.value.text,
    );

    if (getUsersResult.result.status == false ||
        getUsersResult.result.description == "Oyuncu bilgileri yanlış!") {
      getSnackBar(
        getUsersResult.result.description,
        getUsersResult.result.descriptiondetail,
      );
      return;
    }

    useravatarController.value =
        getUsersResult.response!.avatar!.mediaURL.minURL;

    AppList.user.value = User(
      userID: getUsersResult.response!.playerID,
      username: getUsersResult.response!.username,
      password: passcordController.value.text,
      displayname: getUsersResult.response!.displayName,
      firstname: getUsersResult.response!.firstName,
      lastname: getUsersResult.response!.lastName,
      avatar: getUsersResult.response!.avatar!.mediaURL.minURL,
      banner: getUsersResult.response!.banner!.mediaURL.minURL,
    );
  }

  logout() {
    AppList.user.value = null;
  }

  Future<void> savebarriertoken() async {
    // ARMOYU.service.barriertoken = barriertokenController.value.text;
    log(barriertokenController.value.text);
    LoginResponse getUsersResult =
        await ARMOYU.service.authServices.loginwithbarriertoken(
      barriertoken: barriertokenController.value.text,
    );

    if (getUsersResult.result.status == false ||
        getUsersResult.result.description == "Oyuncu bilgileri yanlış!") {
      getSnackBar(
        getUsersResult.result.description,
        getUsersResult.result.descriptiondetail,
      );
      return;
    }

    useravatarController.value =
        getUsersResult.response!.avatar!.mediaURL.minURL;

    AppList.user.value = User(
      userID: getUsersResult.response!.playerID,
      username: getUsersResult.response!.username,
      password: passcordController.value.text,
      displayname: getUsersResult.response!.displayName,
      firstname: getUsersResult.response!.firstName,
      lastname: getUsersResult.response!.lastName,
      avatar: getUsersResult.response!.avatar!.mediaURL.minURL,
      banner: getUsersResult.response!.banner!.mediaURL.minURL,
    );
  }
}
