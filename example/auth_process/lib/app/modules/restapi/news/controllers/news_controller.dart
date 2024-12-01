import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/news.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsfetchStatus = false.obs;

  var newsList = <News>[].obs;

  fetchnews() async {
    newsfetchStatus.value = true;
    List<News> response = await ARMOYU.service.newsServices.fetch(
      username: AppList.user.value!.username!,
      password: AppList.user.value!.password!,
      page: 1,
    );

    newsList.addAll(response);

    newsfetchStatus.value = false;

    log(response.toString());
  }
}
