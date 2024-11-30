import 'package:auth_process/app/modules/restapi/login/controllers/login_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController(), permanent: true);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundImage: CachedNetworkImageProvider(
                                controller.useravatarController.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Obx(
                              () => Visibility(
                                visible: AppList.user.value == null,
                                child: ARMOYU.widgets.textField.costum3(
                                  controller:
                                      controller.usernameController.value,
                                  title: "Username",
                                  onChanged: (val) {
                                    //Important for state
                                    controller.usernameController.refresh();
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: AppList.user.value == null,
                                child: ARMOYU.widgets.textField.costum3(
                                  controller:
                                      controller.passcordController.value,
                                  title: "Password",
                                  isPassword: true,
                                  onChanged: (val) {
                                    //Important for state
                                    controller.passcordController.refresh();
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => AppList.user.value == null
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Username: ${AppList.user.value!.username!}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                            Obx(
                              () => AppList.user.value == null
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Display Name: ${AppList.user.value!.firstname!}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: AppList.user.value == null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          ARMOYU.widgets.elevatedButton.costum1(
                                        text: "Login",
                                        onPressed: () async {
                                          controller.loginstaus.value = true;

                                          await controller.login();
                                          controller.loginstaus.value = false;
                                        },
                                        loadingStatus:
                                            controller.loginstaus.value,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: AppList.user.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          ARMOYU.widgets.elevatedButton.costum1(
                                        text: "Logout",
                                        onPressed: () async {
                                          controller.loginstaus.value = true;

                                          await controller.logout();
                                          controller.loginstaus.value = false;
                                        },
                                        loadingStatus:
                                            controller.loginstaus.value,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchAuthUrl(context),
              child: const Text("ARMOYU ile Giriş"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchAuthUrl(BuildContext context) async {
  if (await canLaunchUrlString(authUrl)) {
    await launchUrlString(authUrl);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Yetkilendirme ekranı açılamıyor.")),
    );
  }
}

String authUrl = "https://armoyu.com/auth/login"; // Giriş ekranı URL'i
