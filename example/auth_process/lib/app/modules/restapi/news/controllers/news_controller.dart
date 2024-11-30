import 'dart:developer';

import 'package:armoyu_services/core/models/ARMOYU/media.dart';
import 'package:armoyu_services/core/models/ARMOYU/news.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:auth_process/app/utils/app_list.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsfetchStatus = false.obs;

  var newsList = <News>[].obs;

  fetchnews() async {
    newsfetchStatus.value = true;
    Map<String, dynamic> response = await ARMOYU.service.newsServices.fetch(
      username: AppList.user.value!.username!,
      password: AppList.user.value!.password!,
      page: 1,
    );

    if (response['durum'] == 0) {
      return;
    }

    for (var element in response['icerik']) {
      newsList.add(
        News(
          newsID: element['haberID'],
          newsURL: element['link'],
          newsOwner: NewsOwner(
            userID: element['yazarID'],
            displayname: element['yazar'],
            avatar: MediaURL(
              bigURL: element['yazaravatar'],
              normalURL: element['yazaravatar'],
              minURL: element['yazaravatar'],
            ),
          ),
          title: element['haberbaslik'],
          content: null,
          summary: element['ozet'],
          media: Media(
            mediaID: 0,
            mediaURL: MediaURL(
              bigURL: element['resim'],
              normalURL: element['resimorijinal'],
              minURL: element['resimminnak'],
            ),
          ),
          date: element['gecenzaman'],
          category: element['kategori'],
          views: element['goruntulen'],
        ),
      );
    }

    newsfetchStatus.value = false;

    log(response.toString());
  }
}
