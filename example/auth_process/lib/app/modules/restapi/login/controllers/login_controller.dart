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

//Profile

  var useravatarController =
      "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu128.png".obs;

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
        "$description\n$descriptiondetail",
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    } catch (e) {
      Get.snackbar(
        "Sistem",
        description,
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
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
    log(getUsersResult.response.toString());

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

    log(AppList.user.value!.username!);
  }

  logout() {
    AppList.user.value = null;
  }

  Future<void> befriend() async {
    final getUsersResult = await ARMOYU.service.userServices.addFriend(
      addFriendRequestModel: AddFriendRequestModel(
        kiminle: 2,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      // getSnackBar(
      //   getUsersResult.result.description,
      //   getUsersResult.result.descriptiondetail,
      // );
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
        await ARMOYU.service.authServices.register(
      registerRequestModel: RegisterRequestModel(
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        password: password,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      // getSnackBar(getUsersResult);
      return;
    }
  }
}
