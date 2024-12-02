import 'package:auth_process/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text("ARMOYU Services")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "ARMOYU SERVICES",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => Get.toNamed("/forms"),
                    child: const Text("Forms"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => await Get.toNamed("/restapi"),
                    child: const Text("REST API"),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () => controller..changethememode(),
              icon: Obx(
                () => Icon(controller.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode),
              ),
            ),
          ),
          const Center(
            child: Text("Version : 1.0.0+14"),
          ),
        ],
      ),
    );
  }
}
