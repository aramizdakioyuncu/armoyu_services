import 'dart:developer';

import 'package:auth_process/app/modules/restapi/news/controllers/news_controller.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => ARMOYU.widgets.elevatedButton.costum1(
                text: "Get News",
                onPressed: () async {
                  if (AppList.user.value == null) {
                    log("Giriş Yapulmamış");
                    return;
                  }
                  controller.newsfetchStatus.value = true;
                  Map<String, dynamic> response =
                      await ARMOYU.service.newsServices.fetch(
                    username: AppList.user.value!.username!,
                    password: AppList.user.value!.password!,
                    page: 1,
                  );
                  controller.newsfetchStatus.value = false;

                  log(response.toString());
                },
                loadingStatus: controller.newsfetchStatus.value,
              ),
            )
          ],
        ),
      ),
    );
  }
}
