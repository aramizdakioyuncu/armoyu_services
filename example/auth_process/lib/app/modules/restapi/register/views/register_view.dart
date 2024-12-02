import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          children: [
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "Ad",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "Soyad",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "Kullanıcı Adı",
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "E-Posta",
              type: TextInputType.emailAddress,
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "Parola",
              isPassword: true,
              onChanged: (val) {},
            ),
            ARMOYU.widgets.textField.costum3(
              controller: TextEditingController(),
              title: "Parola Tekrarı",
              isPassword: true,
              onChanged: (val) {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ARMOYU.widgets.elevatedButton.costum1(
                text: "KAYIT OL ",
                onPressed: () {},
                loadingStatus: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
