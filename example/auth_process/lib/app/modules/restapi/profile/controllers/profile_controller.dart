import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/API/login&register&password/login.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userIDController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;

  var proccessStatus = false.obs;

  var user = Rx<APILogin?>(null);
  lookprofile() async {
    if (userIDController.value.text.isEmpty) {
      return;
    }
    proccessStatus.value = true;
    LookProfileResponse getUsersResult =
        await ARMOYU.service.utilsServices.lookProfile(
      userID: int.parse(userIDController.value.text),
    );
    proccessStatus.value = false;

    if (!getUsersResult.result.status ||
        getUsersResult.result.description == "Oyuncu bilgileri yanlış!") {
      return;
    }
    user.value = getUsersResult.response!;
  }

  lookprofilewithusername() async {
    if (usernameController.value.text.isEmpty) {
      return;
    }
    proccessStatus.value = true;

    LookProfilewithUsernameResponse getUsersResult =
        await ARMOYU.service.utilsServices.lookProfilewithusername(
      // username: AppList.user.value!.username!,
      // password: AppList.user.value!.password!,
      userusername: usernameController.value.text,
    );
    proccessStatus.value = false;
    if (!getUsersResult.result.status ||
        getUsersResult.result.description == "Oyuncu bilgileri yanlış!") {
      return;
    }

    user.value = getUsersResult.response!;

    log(user.value!.displayName!);
  }
}
