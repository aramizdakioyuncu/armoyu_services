import 'package:auth_process/app/modules/restapi/register/controllers/register_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          children: [
            ARMOYU.widgets.textField.costum3(
              controller: controller.firstnameController.value,
              title: "Ad",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: controller.lastnameController.value,
              title: "Soyad",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: controller.usernameController.value,
              title: "Kullanıcı Adı",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: controller.emailController.value,
              title: "E-Posta",
              type: TextInputType.emailAddress,
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: controller.passwordController.value,
              title: "Parola",
              isPassword: true,
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: controller.rpasswordController.value,
              title: "Parola Tekrarı",
              isPassword: true,
              onChanged: (val) {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => ARMOYU.widgets.elevatedButton.costum1(
                  text: "KAYIT OL ",
                  onPressed: () => controller.register(),
                  loadingStatus: controller.registerStatus.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
