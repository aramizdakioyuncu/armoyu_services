import 'package:armoyu_services/armoyu_services.dart';
import 'package:auth_process/app/modules/restapi/_main/controllers/restapi_controller.dart';
import 'package:auth_process/app/modules/restapi/login/controllers/login_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(title: const Text("Rest API Example")),
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
                              () => ARMOYU.widgets.textField.costum3(
                                controller: controller.usernameController.value,
                                title: "Username",
                                onChanged: (val) {
                                  //Important for state
                                  controller.usernameController.refresh();
                                },
                              ),
                            ),
                            Obx(
                              () => ARMOYU.widgets.textField.costum3(
                                controller: controller.passcordController.value,
                                title: "Password",
                                isPassword: true,
                                onChanged: (val) {
                                  //Important for state
                                  controller.passcordController.refresh();
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ARMOYU.widgets.elevatedButton.costum1(
                                    text: "Login",
                                    onPressed: () async {
                                      controller.loginstaus.value = true;

                                      await controller.login();
                                      controller.loginstaus.value = false;
                                    },
                                    loadingStatus: controller.loginstaus.value,
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
          ],
        ),
      ),
    );
  }
}
