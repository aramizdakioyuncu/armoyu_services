import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var firstnameController = TextEditingController().obs;
  var lastnameController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var rpasswordController = TextEditingController().obs;
  var registerStatus = false.obs;

  Future<void> register() async {
    log(passwordController.value.text.toString());
    log(rpasswordController.value.text.toString());

    registerStatus.value = true;
    RegisterResponse getUsersResult =
        await ARMOYU.service.authServices.register(
      firstname: firstnameController.value.text,
      lastname: lastnameController.value.text,
      email: emailController.value.text,
      username: usernameController.value.text,
      password: passwordController.value.text,
      rpassword: rpasswordController.value.text,
      //  inviteCode:  ,
    );

    registerStatus.value = false;

    if (!getUsersResult.result.status) {
      log(getUsersResult.result.description);
      return;
    }
  }
}
