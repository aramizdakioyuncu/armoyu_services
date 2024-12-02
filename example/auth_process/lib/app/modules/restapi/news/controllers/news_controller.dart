import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/API/news/news_list.dart';
import 'package:armoyu_services/core/models/ARMOYU/_response/response.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsfetchStatus = false.obs;

  var newsList = <APINewsDetail>[].obs;

  fetchnews() async {
    newsfetchStatus.value = true;
    NewsListResponse response = await ARMOYU.service.newsServices.fetch(
      username: AppList.user.value!.username!,
      password: AppList.user.value!.password!,
      page: 1,
    );

    if (response.result.status == false) {
      return log(response.result.description);
    }

    newsList.addAll(response.response!.news);
    newsfetchStatus.value = false;
    log(response.toString());
  }
}