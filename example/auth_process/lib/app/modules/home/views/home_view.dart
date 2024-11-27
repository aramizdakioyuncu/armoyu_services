import 'package:auth_process/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => Get.toNamed("/forms"),
              child: const Text("Test Login"),
            ),
            ElevatedButton(
              onPressed: () async => await Get.toNamed("/restapi"),
              child: const Text("Test Add Friend"),
            ),
          ],
        ),
      ),
    );
  }
}
