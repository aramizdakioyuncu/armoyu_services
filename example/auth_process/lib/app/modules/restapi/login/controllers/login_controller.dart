import 'package:armoyu_services/armoyu_services.dart';
import 'package:auth_process/app/data/models/user.dart';
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
    final getUsersResult = await ARMOYU.service.authServices.previuslogin(
      username: usernameController.value.text,
      password: passcordController.value.text,
    );

    if (getUsersResult['durum'] == 0 ||
        getUsersResult['aciklama'] == "Oyuncu bilgileri yanlış!") {
      getSnackBar(getUsersResult);
      return;
    }
    log(getUsersResult['icerik'].toString());

    useravatarController.value =
        getUsersResult['icerik']['avatar']['media_minURL'];

    AppList.user.value = User(
      userID: getUsersResult['icerik']['playerID'],
      username: getUsersResult['icerik']["username"],
      password: passcordController.value.text,
      displayname: getUsersResult['icerik']["displayName"],
      firstname: getUsersResult['icerik']["firstName"],
      lastname: getUsersResult['icerik']['lastName'],
      avatar: getUsersResult['icerik']['avatar']['media_minURL'],
      banner: getUsersResult['icerik']['banner']['media_minURL'],
    );

    log(AppList.user.value!.username!);
  }

  Future<void> befriend() async {
    final getUsersResult = await ARMOYU.service.userServices.addFriend(
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
      getSnackBar(getUsersResult);
      return;
    }
  }
}
