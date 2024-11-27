import 'dart:developer';

import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchEngineController extends GetxController {
  var searchController = TextEditingController().obs;

  var searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchQuery,
      (value) async {
        Map<String, dynamic> response = await ARMOYU.service.searchServices
            .searchengine(searchword: value, page: 1);

        log(response['icerik'].toString());
      }, // Yazmayı bırakınca çalışacak fonksiyon
      time: const Duration(milliseconds: 500),
    );
  }
}
