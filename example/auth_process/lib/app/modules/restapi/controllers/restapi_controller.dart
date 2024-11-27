import 'package:armoyu_services/armoyu_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestapiController extends GetxController {
  late final ARMOYUServices armoyuServices;
  var loginstaus = false.obs;
  var addfriendstaus = false.obs;
  var registerstaus = false.obs;
  @override
  void onInit() {
    super.onInit();
    armoyuServices = ARMOYUServices(apiKey: "", usePreviousAPI: true);

    armoyuServices.setup();
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

  Future<void> login() async {
    final Map<String, dynamic> getUsersResult =
        await armoyuServices.authServices.login(
      loginRequestModel: LoginRequestModel(
        username: "deneme",
        password: "deneme",
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> previuslogin() async {
    final getUsersResult = await armoyuServices.authServices
        .previuslogin(username: "deneme", password: "deneme");
    getSnackBar(getUsersResult);

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> befriend() async {
    final getUsersResult = await armoyuServices.userServices.addFriend(
      addFriendRequestModel: AddFriendRequestModel(
        kiminle: 2,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> register({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> getUsersResult =
        await armoyuServices.authServices.register(
      registerRequestModel: RegisterRequestModel(
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        password: password,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
      return;
    }
  }
}
